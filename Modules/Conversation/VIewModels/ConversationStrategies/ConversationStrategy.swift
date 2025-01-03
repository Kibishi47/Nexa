//
//  ChatStrategyProtocol.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

protocol ConversationStrategy {
    var chatGPTService: ChatGPTService { get }
    func sendData(message: String) async -> String
}
