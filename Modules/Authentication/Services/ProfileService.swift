//
//  AuthenticationService.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/12/2024.
//

import Foundation
import Supabase

class ProfileService {
    
    private static var instance: ProfileService? = nil
    
    private init() {}
    
    static func getInstance() -> ProfileService {
        if instance == nil {
            instance = ProfileService()
        }
        return instance!
    }
    
    func fetchProfileByUserId(_ userId: UUID) async -> Profile? {
        do {
            let profile: Profile = try await supabaseClient
                .from("profiles")
                .select()
                .eq("user_id", value: userId)
                .single()
                .execute()
                .value
            return profile
        } catch {
            print("error getting profile: \(error)")
            return nil
        }
    }
    
    func updateUsernameProfile(_ profile: Profile, completion: @escaping (_ success: Bool, _ error: Supabase.PostgrestError?) -> Void) async {
        do {
            try await supabaseClient
                .from("profiles")
                .update(["username": profile.username])
                .eq("id", value: profile.id)
                .execute()
            completion(true, nil)
        } catch let supabaseError as Supabase.PostgrestError {
            print("error updating username profile: \(supabaseError)")
            completion(false, supabaseError)
        } catch {
            print("error updating username profile: \(error)")
            completion(false, nil)
        }
    }
}
