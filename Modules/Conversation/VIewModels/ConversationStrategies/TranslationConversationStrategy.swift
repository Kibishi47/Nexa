//
//  ChatStrategy.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

class TranslationConversationStrategy: ConversationStrategy {
    var chatGPTService = ChatGPTService.getInstance()
    
    func sendData(message: String) async -> String {
        let data = [
            "target_language": "english",
            "text": message
        ]
        let response = await chatGPTService.send(url: "translate", data: data)
        return response["response"]! as! String
    }
}
