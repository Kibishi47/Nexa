//
//  Conversation.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

struct Conversation: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    var title: String
    var featureName: String
    var createdAt: CreatedAtSupabase
    var messages: [Message] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title
        case featureName = "feature_name"
        case createdAt = "created_at"
        case messages
    }
    
    var feature: AIFeature {
        AIFeature.fromKey(featureName)
    }
    
    var lastMessage: Message? {
        messages.last
    }
    
//    var messages: [Message] {
//        []
//    }
    
    var date: Date {
        createdAt.toDate()
    }
    
    var lastDateActivity: Date {
        messages.last?.createdAt.toDate() ?? date
    }
}
