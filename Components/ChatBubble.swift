//
//  ChatBubble.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage
    let hideNexa: Bool
    
    init(message: ChatMessage, hideNexa: Bool = false) {
        self.message = message
        self.hideNexa = hideNexa
    }
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            VStack(alignment: message.isUser ? .trailing : .leading) {
                if !message.isUser && !hideNexa {
                    AIMascot(animationsEnabled: false)
                        .scaleEffect(0.5)
                        .frame(width: 5, height: 5)
                }
                
                Text(message.content)
                    .padding()
                    .background(message.isUser ? Color.blue.opacity(0.8) : Color.gray.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .frame(maxWidth: 280, alignment: message.isUser ? .trailing : .leading)
            }
            
            if !message.isUser { Spacer() }
        }
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        ChatBubble(
            message: ChatMessage(
                id: UUID(),
                content: "Bonjour ! Je suis Nexa, votre assistant IA. Comment puis-je vous aider aujourd'hui ?",
                isUser: false,
                timestamp: Date()
            )
        )
    }
}
