//
//  ChatStrategy.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

class ImageConversationStrategy: ConversationStrategy {
    var chatGPTService = ChatGPTService.getInstance()
    var dataManager: DataManager
    var feature: AIFeature
    
    required init(_ feature: AIFeature) {
        self.dataManager = DataManager.getInstance()
        self.feature = feature
    }
    
    func sendData(conversation: Conversation, message: String) async -> String {
        let data = ["prompt": message]
        let response = await chatGPTService.send(url: "image", data: data)
        return getGPTMessage(response)
    }
}
