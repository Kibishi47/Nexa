//
//  AuthenticationService.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/12/2024.
//

import Foundation
import Supabase

class AuthService {
    
    private static var instance: AuthService? = nil
    
    protocol Observer {
        func onAuthStateChange(_ state: AuthState) -> Void
    }
    
    enum AuthState {
        case loggedIn
        case loggedOut
    }
    
    var observers: [Observer] = []
    var allowNotify = true
    
    private init() {
        Task {
            await self.configureAuthStateListener()
        }
    }
    
    static func getInstance() -> AuthService {
        if instance == nil {
            instance = AuthService()
        }
        return instance!
    }
    
    private func configureAuthStateListener() async {
        for await (event, _) in supabaseClient.auth.authStateChanges {
            if allowNotify {
                print("auth state change: \(event.rawValue)")
                switch event {
                case .initialSession:
                    await refreshSession()
                case .signedIn:
                    notifyObservers(state: .loggedIn)
                case .signedOut:
                    notifyObservers(state: .loggedOut)
                case .userDeleted:
                    notifyObservers(state: .loggedOut)
                default:
                    break
                }
            } else {
                allowNotify = true
            }
        }
    }
    
    func subscribe(_ observer: Observer) {
        self.observers.append(observer)
    }
    
    private func notifyObservers(state: AuthState) {
        DispatchQueue.main.async {
            self.observers.forEach { $0.onAuthStateChange(state) }
        }
    }
    
    func register(email: String, password: String, username: String, completion: @escaping (_ isSucceed: Bool, _ error: NexaError?) -> Void) async {
        do {
            try await supabaseClient.auth.signUp(email: email, password: password, data: [
                "username": .string(username)
            ])
            completion(true, nil)
        } catch let authError as Supabase.AuthError {
            print("Failed to register. \(authError.localizedDescription)")
            completion(false, authError.toNexaError)
        } catch {
            print("Failed to register. \(error.localizedDescription)")
            completion(false, .unknownError)
        }
    }
    
    func login(email: String, password: String, blockingNotify: Bool = false, completion: @escaping (_ isSucceed: Bool, _ error: NexaError?) -> Void) async {
        allowNotify = !blockingNotify
        do {
            try await supabaseClient.auth.signIn(email: email, password: password)
            completion(true, nil)
        } catch let authError as Supabase.AuthError {
            print("Failed to login. \(authError.localizedDescription)")
            completion(false, authError.toNexaError)
        } catch {
            print("Failed to login. \(error.localizedDescription)")
            completion(false, .unknownError)
        }
    }
    
    func logout(completion: @escaping (_ isSucceed: Bool, _ error: NexaError?) -> Void) async {
        do {
            try await supabaseClient.auth.signOut()
            completion(true, nil)
        } catch let authError as Supabase.AuthError {
            print("Failed to register. \(authError.localizedDescription)")
            completion(false, authError.toNexaError)
        } catch {
            print("Failed to logout. \(error.localizedDescription)")
            completion(false, .unknownError)
        }
    }
    
    func isAuthenticated() -> Bool {
        return supabaseClient.auth.currentSession != nil
    }
    
    private func refreshSession() async {
        do {
            if supabaseClient.auth.currentSession != nil {
                try await supabaseClient.auth.refreshSession()
            }
        } catch {
            print("error refresh session: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async -> Supabase.User? {
        do {
            return try await supabaseClient.auth.user()
        } catch {
            print("error get user: \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateUserEmail(user: Supabase.User, completion: @escaping (_ isSucceed: Bool, _ error: NexaError?) -> Void) async {
        do {
            let _ = try await supabaseClient.auth.update(user: UserAttributes(email: user.email))
            completion(true, nil)
        } catch let authError as Supabase.AuthError {
            print("error updating user email: \(authError.localizedDescription)")
            completion(false, authError.toNexaError)
        } catch {
            print("error updating user email: \(error.localizedDescription)")
            completion(false, .unknownError)
        }
    }
    
    func updateUserPassword(password: String, completion: @escaping (_ isSucceed: Bool, _ error: NexaError?) -> Void) async {
        do {
            let _ = try await supabaseClient.auth.update(user: UserAttributes(password: password))
            completion(true, nil)
        } catch let authError as Supabase.AuthError {
            print("error updating user password: \(authError.localizedDescription)")
            completion(false, authError.toNexaError)
        } catch {
            print("error updating user password: \(error.localizedDescription)")
            completion(false, .unknownError)
        }
    }
}
