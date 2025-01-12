//
//  ChatViewModel.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

class ConversationViewModel: ObservableObject {
    let conversation: Conversation
    @Published var messages: [Message] = []
    @Published var userText: String = ""
    @Published var isTyping: Bool = false
    
    var strategy: ConversationStrategy
    
    init(conversation: Conversation?, feature: AIFeature) {
        let _conversation = conversation ?? Conversation(
            id: UUID(),
            userId: UUID(),
            title: "",
            featureName: feature.key,
            createdAt: CreatedAtSupabase(Date().ISO8601Format())
        )
        self.conversation = _conversation
        self.messages = self.conversation.messages
        self.strategy = feature.conversationStrategy
        
        if (conversation == nil) {
            self.addMessage(message: _conversation.feature.firstMessage, role: "assistant")
        }
    }
    
    func submitText() async {
        let text = self.userText
        self.setUserText("")
        self.addMessage(message: text, role: "user")
        
        self.setIsTyping(true)
        let AIResponse = await strategy.sendData(conversation: self.conversation, message: text)
        self.addMessage(message: AIResponse, role: "assistant")
        self.setIsTyping(false)
    }
    
    private func addMessage(message: String, role: String) {
        let newMessage = Message(
            id: UUID(),
            conversationId: conversation.id,
            role: role,
            content: message,
            createdAt: CreatedAtSupabase(Date().ISO8601Format()))
        DispatchQueue.main.async {
            self.messages.append(newMessage)
        }
    }
    
    private func setUserText(_ text: String) {
        DispatchQueue.main.async {
            self.userText = text
        }
    }
    
    private func setIsTyping(_ isTyping: Bool) {
        DispatchQueue.main.async {
            self.isTyping = isTyping
        }
    }
}
