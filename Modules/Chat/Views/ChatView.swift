//
//  ChatView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @State private var messages: [ChatMessage] = []
    @State private var newMessage = ""
    @State private var isTyping = false
    @FocusState private var isInputFocused: Bool
    var chatId: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            NavigateBackHeader(
                title: "Chat avec Nexa"
            )
            .padding()
            .background(Color.black.opacity(0.5))
            
            // Chat messages
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(Array(messages.enumerated()), id: \.1.id) { index, message in
                            let lastMessage = index > 0 ? messages[index - 1] : nil
                            let hideNexa = lastMessage?.isUser == false // Hide Nexa if the last message is from a Nexa
                            ChatBubble(message: message, hideNexa: hideNexa)
                                .id(message.id)
                        }
                    }
                    .padding()
                    .padding(.top, 40)
                }
                //                .onChange(of: messages) { _ in
                //                    withAnimation {
                //                        proxy.scrollTo(messages.last?.id, anchor: .bottom)
                //                    }
                //                }
            }
            
            // Typing indicator
            if isTyping {
                HStack {
                    Text("Nexa est en train d'écrire...")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            
            // Input area
            HStack(spacing: 12) {
                TextField("Tapez votre message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(8)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .focused($isInputFocused)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                        .frame(width: 40, height: 40)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                }
                .disabled(newMessage.isEmpty)
            }
            .padding()
            .background(Color.black.opacity(0.5))
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            addWelcomeMessage()
        }
    }
    
    private func addWelcomeMessage() {
        let welcomeMessage = ChatMessage(id: UUID(), content: "Bonjour ! Je suis Nexa, votre assistant IA. Comment puis-je vous aider aujourd'hui ?", isUser: false, timestamp: Date())
        messages.append(welcomeMessage)
    }
    
    private func sendMessage() {
        let userMessage = ChatMessage(id: UUID(), content: newMessage, isUser: true, timestamp: Date())
        messages.append(userMessage)
        
        // Clear the input field
        newMessage = ""
        
        // Simulate AI response
        isTyping = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isTyping = false
            let aiResponse = ChatMessage(id: UUID(), content: generateAIResponse(to: userMessage.content), isUser: false, timestamp: Date())
            messages.append(aiResponse)
        }
    }
    
    private func generateAIResponse(to userMessage: String) -> String {
        // This is a placeholder. In a real app, this would call an AI service.
        let responses = [
            "C'est une excellente question ! Pouvez-vous m'en dire plus ?",
            "Je comprends votre point de vue. Voici ce que je pense...",
            "Intéressant ! Avez-vous considéré cet aspect ?",
            "D'après mes données, voici ce que je peux vous dire sur ce sujet...",
            "Je suis là pour vous aider. Que voulez-vous savoir d'autre ?"
        ]
        return responses.randomElement() ?? "Je suis désolé, je n'ai pas compris. Pouvez-vous reformuler ?"
    }
}

#Preview {
    ChatView(chatId: nil)
        .environmentObject(NavigationManager())
}

