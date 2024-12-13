//
//  AuthenticationService.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/12/2024.
//

import Foundation
import Supabase

class ProfileService {
    
    static let instance = ProfileService()
    
    private init() {}
    
    func getProfileByUserId(_ userId: UUID) async -> Profile? {
        do {
            let profile: Profile = try await supabaseClient
                .from("profiles")
                .select("id, user_id, username, avatar_url")
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
}
