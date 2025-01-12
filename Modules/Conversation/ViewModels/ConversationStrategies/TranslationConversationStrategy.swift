//
//  ChatStrategy.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

class TranslationConversationStrategy: ConversationStrategy {
    var chatGPTService = ChatGPTService.getInstance()
    var languageManager = LanguageManager.getInstance()
    var dataManager: DataManager
    var feature: AIFeature
    
    required init(_ feature: AIFeature) {
        self.dataManager = DataManager.getInstance()
        self.feature = feature
    }
    
    func sendData(conversation: Conversation, message: String) async -> String {
        let data = [
            "text": message,
            "target_language": languageManager.selectedLanguage.name,
            "conversation_id": conversation.id.uuidString,
            "user_id": dataManager.user?.id.uuidString ?? "",
            "feature_name": feature.key
        ] as [String : String]
        let response = await chatGPTService.send(url: feature.url, data: data)
        return getGPTMessage(response)
    }
}
