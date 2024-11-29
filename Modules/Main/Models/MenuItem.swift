//
//  MenuItem.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

enum MenuItem: String, Identifiable {
    case main = "Accueil"
    case profile = "Profil"
    case subscription = "Abonnement"
    case history = "Historique"
    case logout = "Déconnexion"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .main: return "house"
        case .profile: return "person.circle"
        case .subscription: return "star"
        case .history: return "clock"
        case .logout: return "rectangle.portrait.and.arrow.right"
        }
    }
}
