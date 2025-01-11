//
//  Message.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

struct Message: Identifiable, Codable, Equatable {
    let id: UUID
    let conversationId: UUID
    let role: String
    let content: String
    let createdAt: CreatedAtSupabase
    
    enum CodingKeys: String, CodingKey {
        case id
        case conversationId = "conversation_id"
        case role
        case content
        case createdAt = "created_at"
    }
    
    var isUser: Bool {
        role == "user"
    }
}
