//
//  ChatListView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @State private var chats: [Chat] = ChatRepository().getChats()
    @State private var isShowingNewChat = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            NavigateBackHeader(title: "Chats")
                .padding()
            
            // Chat list
            ScrollView {
                LazyVStack(spacing: 16) {
                    Button(action: {
                        navigationManager.navigateToChat(id: nil)
                    }, label: {
                        NewChatRowView()
                    })
                    ForEach(chats) { chat in
                        Button(action: {
                            navigationManager.navigateToChat(id: chat.id)
                        }, label: {
                            ChatRowView(chat: chat)
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
    ChatListView()
        .environmentObject(NavigationManager())
}
