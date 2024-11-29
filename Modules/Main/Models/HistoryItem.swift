//
//  HistoryItem.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import Foundation

struct HistoryItem: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let type: AIFeature
}
