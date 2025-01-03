//
//  AIFeature.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

enum AIFeature: String, Identifiable, CaseIterable {
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
    
    var firstMessage: String {
        switch self {
        case .chat:
            return "Salut ! Dis-moi ce que tu as en tête ou pose-moi une question, je suis là pour t'aider !"
        case .imageGeneration:
            return "Imagine une scène incroyable... Décris-la et laisse-moi te surprendre avec une image unique !"
        case .transcription:
            return "Prêt à transformer l'audio en texte clair et précis ? Enregistre ou importe un fichier et c'est parti !"
        case .translation:
            return "Besoin d'une traduction rapide ? Écris ton texte et choisis la langue de destination. Je m’occupe du reste !"
        case .summarization:
            return "Un long texte à résumer ? Colle-le ici et je vais en extraire l'essentiel pour toi."
        case .documentAnalysis:
            return "Téléverse un document ou une image avec du texte, et je vais te donner les informations clés en un instant."
        case .socialPostGeneration:
            return "Envie d’un post percutant pour tes réseaux ? Donne-moi un sujet, et je vais te créer un message prêt à publier !"
        case .voiceCustomization:
            return "Écris quelques lignes, choisis une voix sympa et écoute le résultat. Ça va être top !"
        }
    }
    
    static func fromKey(_ key: String, default feature: AIFeature = .chat) -> AIFeature {
        return Self.allCases.first(where: { "\($0)" == key }) ?? feature
    }
    
    var key: String {
        String(describing: self)
    }
}
