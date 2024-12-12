//
//  SupabaseExtensions.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 12/12/2024.
//

import Foundation
import Supabase

extension Supabase.AuthError {
    
    var localizedDescriptionInFrench: String {
        switch self.errorCode.rawValue {
        case "anonymous_provider_disabled":
            return "Connexion anonyme désactivée."
        case "invalid_credentials":
            return "Identifiants invalides."
        case "email_not_confirmed":
            return "E-mail non confirmé."
        case "email_exists":
            return "E-mail déjà utilisé."
        case "session_expired":
            return "Session expirée."
        case "user_not_found":
            return "Utilisateur introuvable."
        case "weak_password":
            return "Mot de passe trop faible."
        case "over_request_rate_limit":
            return "Trop de requêtes. Réessayez plus tard."
        case "user_banned":
            return "Utilisateur banni."
        case "provider_disabled":
            return "Fournisseur désactivé."
        case "otp_expired":
            return "Code OTP expiré."
        case "phone_exists":
            return "Téléphone déjà utilisé."
        case "email_provider_disabled":
            return "Inscription par e-mail désactivée."
        default:
            return "Une erreur inconnue est survenue. Veuillez réessayer."
        }
    }
}
