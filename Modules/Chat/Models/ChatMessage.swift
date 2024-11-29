//
//  ChatMessage.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import Foundation

struct ChatMessage: Identifiable {
    let id: UUID
    let content: String
    let isUser: Bool
    let timestamp: Date
}
