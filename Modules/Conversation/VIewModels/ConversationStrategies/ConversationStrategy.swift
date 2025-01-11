//
//  ChatStrategyProtocol.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

protocol ConversationStrategy {
    var chatGPTService: ChatGPTService { get }
    var dataManager: DataManager { get set }
    var feature: AIFeature { get set }
    init(_ feature: AIFeature)
    func sendData(conversation: Conversation, message: String) async -> String
}

extension ConversationStrategy {
    func getGPTMessage(_ GPTResponse: [String: Any]) -> String {
        let response = GPTResponse["response"]! as! [String: Any]
        return response["message"]! as! String
    }
}
