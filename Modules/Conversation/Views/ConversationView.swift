//
//  ChatView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @StateObject private var viewModel: ConversationViewModel
    private let feature: AIFeature
    
    init(conversation: Conversation?, feature: AIFeature) {
        self.feature = feature
        _viewModel = StateObject(wrappedValue: ConversationViewModel(conversation: conversation, feature: feature))
    }
    
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
                        ForEach(Array(viewModel.messages.enumerated()), id: \.1.id) { index, message in
                            let lastMessage: Message? = index > 0 ? viewModel.messages[index - 1] : nil
                            let hideNexa = !(lastMessage?.isUser ?? true) // Hide Nexa if the last message is from a Nexa
                            ChatBubble(message: message, hideNexa: hideNexa)
                                .id(message.id)
                        }
                    }
                    .padding()
                    .padding(.top, 40)
                }
                .onChange(of: viewModel.messages) { _ in
                    withAnimation {
                        proxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                    }
                }
                .onAppear {
                    proxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                }
            }
            
            // Typing indicator
            if viewModel.isTyping {
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
                CustomTextField(placeholder: "Tapez votre message...", systemImage: "", isSecure: false, text: $viewModel.userText)
                
                Button(action: {
                    Task {
                        await viewModel.submitText()
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                        .frame(width: 40, height: 40)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                }
                .disabled(viewModel.userText.isEmpty)
            }
            .padding()
            .background(Color.black.opacity(0.5))
        }
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color.black,
                        feature.color.dark
                    ]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    ConversationView(conversation: nil, feature: .translation)
        .environmentObject(NavigationManager())
}

