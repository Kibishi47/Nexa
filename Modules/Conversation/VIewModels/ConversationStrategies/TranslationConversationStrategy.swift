//
//  ChatStrategy.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

class TranslationConversationStrategy: ConversationStrategy {
    var chatGPTService = ChatGPTService.getInstance()
    var dataManager: DataManager
    var feature: AIFeature
    
    required init(_ feature: AIFeature) {
        self.dataManager = DataManager.getInstance()
        self.feature = feature
    }
    
    func sendData(conversation: Conversation, message: String) async -> String {
        let data = [
            "target_language": "english",
            "text": message
        ]
        let response = await chatGPTService.send(url: "translate", data: data)
        return getGPTMessage(response)
    }
}
