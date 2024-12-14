//
//  DataManager.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 14/12/2024.
//

import Foundation
import Supabase

class DataManager: AuthService.Observer {
    private static var instance: DataManager? = nil
    
    var user: Supabase.User?
    var profile: Profile?
    
    private let authService = AuthService.getInstance()
    private let profileService = ProfileService.getInstance()
    
    private init() {
        authService.subscribe(self)
        Task {
            await fetchUserData()
        }
    }
    
    static func getInstance() -> DataManager {
        if instance == nil {
            instance = DataManager()
        }
        return instance!
    }
    
    func onAuthStateChange(_ state: AuthService.AuthState) {
        switch state {
        case .loggedIn:
            Task {
                await fetchUserData()
            }
        case .loggedOut:
            user = nil
            profile = nil
        }
    }
    
    func fetchUserData() async -> Bool {
        if authService.isAuthenticated() {
            if let user = await authService.fetchUser() {
                self.user = user
                if let profile = await profileService.fetchProfileByUserId(user.id) {
                    self.profile = profile
                    return true
                }
            }
        }
        return false
    }
}
