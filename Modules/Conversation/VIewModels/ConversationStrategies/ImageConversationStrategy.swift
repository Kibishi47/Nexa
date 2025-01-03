//
//  ChatStrategy.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

class ImageConversationStrategy: ConversationStrategy {
    var chatGPTService = ChatGPTService.getInstance()
    
    func sendData(message: String) async -> String {
        let data = ["prompt": message]
        let response = await chatGPTService.send(url: "image", data: data)
        return response["response"]! as! String
    }
}
