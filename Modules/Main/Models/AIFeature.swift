//
//  AIFeature.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

enum AIFeature: String, Identifiable {
    case chat = "Chat IA"
    case imageGeneration = "Génération d'images"
    case transcription = "Transcription audio"
    case translation = "Traduction"
    case summarization = "Résumé de texte"
    case documentAnalysis = "Analyse de documents"
    case socialPostGeneration = "Création de posts sociaux"
    case voiceCustomization = "Personnalisation vocale"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .chat: return "message"
        case .imageGeneration: return "photo.artframe"
        case .transcription: return "waveform"
        case .translation: return "globe"
        case .summarization: return "text.redaction"
        case .documentAnalysis: return "doc.text.magnifyingglass"
        case .socialPostGeneration: return "bubble.left.and.bubble.right.fill"
        case .voiceCustomization: return "speaker.wave.2.circle"
        }
    }
    
    var description: String {
        switch self {
        case .chat: return "Discute avec une IA avancée"
        case .imageGeneration: return "Crée des images uniques"
        case .transcription: return "Convertis l'audio en texte"
        case .translation: return "Traduis dans toutes les langues"
        case .summarization: return "Résume n'importe quel texte"
        case .documentAnalysis: return "Analyse et extraits des informations clés d'un document"
        case .socialPostGeneration: return "Crée des captions ou posts adaptés aux réseaux sociaux"
        case .voiceCustomization: return "Transforme le texte en voix personnalisée et réaliste"
        }
    }
    
    var color: Color {
        switch self {
        case .chat: return .blue
        case .imageGeneration: return .purple
        case .transcription: return .green
        case .translation: return .orange
        case .summarization: return .pink
        case .documentAnalysis: return .yellow
        case .socialPostGeneration: return .red
        case .voiceCustomization: return .cyan
        }
    }
}
