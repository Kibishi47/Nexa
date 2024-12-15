//
//  NexaError.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 15/12/2024.
//

import Foundation

enum NexaError: Error {
    case unknownError
    case emptyFields
    case invalidConfirmPassword
    case invalidCredentials
    case emailNotConfirmed
    case emailExists
    case expiredSession
    case userNotFound
    case weakPassword
    case failToFetchData
    case failToUpdateData
    
    var description: String {
        switch self {
        case .emptyFields:
            return "empty_field".translate()
        case .invalidConfirmPassword:
            return "invalid_confirm_password".translate()
        case .invalidCredentials:
            return "invalid_credentials".translate()
        case .emailNotConfirmed:
            return "email_not_confirmed".translate()
        case .emailExists:
            return "email_exists".translate()
        case .expiredSession:
            return "expired_session".translate()
        case .userNotFound:
            return "user_not_found".translate()
        case .weakPassword:
            return "weak_password".translate()
        case .failToFetchData:
            return "fail_fetch_data".translate()
        case .failToUpdateData:
            return "fail_update_data".translate()
        default:
            return "default_error".translate()
        }
    }
    
    var frenchDescription: String {
        switch self {
        case .emptyFields:
            return "Certains champs sont vides"
        case .invalidConfirmPassword:
            return "La confirmation du mot de passe ne correspond pas"
        case .invalidCredentials:
            return "Identifiants invalides"
        case .emailNotConfirmed:
            return "Adresse e-mail non confirmée"
        case .emailExists:
            return "L'adresse e-mail existe déjà"
        case .expiredSession:
            return "Session expirée"
        case .userNotFound:
            return "Utilisateur non trouvé"
        case .weakPassword:
            return "Mot de passe trop faible"
        case .failToFetchData:
            return "Erreur lors du chargement des données"
        case .failToUpdateData:
            return "Erreur lors de la mise à jour des données"
        default:
            return "Une erreur est survenue, veuillez réessayer"
        }
    }
}
