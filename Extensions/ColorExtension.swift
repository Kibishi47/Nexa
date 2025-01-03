//
//  ColorExtension.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation
import SwiftUI

extension Color {
    var dark: Color {
        switch self {
        case .blue:
            return Color(red: 0.1, green: 0.1, blue: 0.2) // Bleu sombre
        case .purple:
            return Color(red: 0.2, green: 0.1, blue: 0.3) // Violet profond
        case .green:
            return Color(red: 0.1, green: 0.2, blue: 0.1) // Vert foncé
        case .orange:
            return Color(red: 0.2, green: 0.15, blue: 0.05) // Orange brûlé
        case .pink:
            return Color(red: 0.3, green: 0.1, blue: 0.2) // Rose sombre
        case .yellow:
            return Color(red: 0.25, green: 0.25, blue: 0.1) // Jaune doré foncé
        case .red:
            return Color(red: 0.3, green: 0.1, blue: 0.1) // Rouge sombre
        case .cyan:
            return Color(red: 0.1, green: 0.2, blue: 0.3) // Cyan profond
        default:
            return Color(red: 0.05, green: 0.05, blue: 0.05) // Couleur sombre par défaut si non prise en charge
        }
    }
}
