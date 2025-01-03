//
//  FeatureRepository.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

struct FeatureRepository {
    private let AIFeatures: [AIFeature] = [
        .chat, .imageGeneration, .transcription, .translation, .summarization, .documentAnalysis, .socialPostGeneration, .voiceCustomization
    ]
    
    func getHistoryItems() -> [AIFeature] {
        AIFeatures
    }
}
