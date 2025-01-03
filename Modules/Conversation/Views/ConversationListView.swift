//
//  ChatListView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct ConversationListView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    let feature: AIFeature
    @State private var conversations: [Conversation] = []
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            NavigateBackHeader(title: "Chats")
                .padding()
            
            // Chat list
            ScrollView {
                LazyVStack(spacing: 16) {
                    Button(action: {
                        navigationManager.navigateToConversation(conversation: nil, feature: feature)
                    }, label: {
                        NewConversationRowView(feature: feature)
                    })
                    ForEach(conversations) { conversation in
                        Button(action: {
                            navigationManager.navigateToConversation(conversation: conversation, feature: feature)
                        }, label: {
                            ConversationRowView(conversation: conversation)
                        })
                    }
                }
                .padding()
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    ConversationListView(feature: .chat)
        .environmentObject(NavigationManager())
}
