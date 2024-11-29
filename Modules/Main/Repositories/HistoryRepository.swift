//
//  HistoryRepository.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import Foundation

struct HistoryRepository {
    private let historyItems: [HistoryItem] = [
        HistoryItem(title: "Conversation sur l'IA", date: "28 Nov", type: .chat),
        HistoryItem(title: "Image de paysage", date: "27 Nov", type: .imageGeneration),
        HistoryItem(title: "Transcription réunion", date: "26 Nov", type: .transcription),
        HistoryItem(title: "Traduction français-anglais", date: "25 Nov", type: .translation),
        HistoryItem(title: "Résumé article scientifique", date: "24 Nov", type: .summarization)
    ]
    
    func getHistoryItems() -> [HistoryItem] {
        historyItems
    }
}
