//
//  ChatStrategy.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

class MessageConversationStrategy: ConversationStrategy {
    var chatGPTService = ChatGPTService.getInstance()
    var dataManager: DataManager
    var feature: AIFeature
    
    required init(_ feature: AIFeature) {
        self.dataManager = DataManager.getInstance()
        self.feature = feature
    }
    
    func sendData(conversation: Conversation, message: String) async -> String {
        let data = [
            "prompt": message,
            "conversation_id": conversation.id.uuidString,
            "user_id": dataManager.user?.id.uuidString ?? ""
        ] as [String : String]
        let response = await chatGPTService.send(url: feature.url, data: data)
        return getGPTMessage(response)
    }
}
