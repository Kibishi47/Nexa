//
//  SupabaseExtensions.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 12/12/2024.
//

import Foundation
import Supabase

extension Supabase.AuthError {
    
    var toNexaError: NexaError {
        switch self.errorCode.rawValue {
        case "invalid_credentials":
            return .invalidCredentials
        case "email_not_confirmed":
            return .emailNotConfirmed
        case "email_exists":
            return .emailExists
        case "session_expired":
            return .expiredSession
        case "user_not_found":
            return .userNotFound
        case "weak_password":
            return .weakPassword
        default:
            return .unknownError
        }
    }
}
