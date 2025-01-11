//
//  ChatRowView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct ConversationRowView: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "bubble.left.and.bubble.right.fill")
                .font(.system(size: 40))
                .foregroundColor(conversation.feature.color)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(conversation.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack(spacing: 5) {
                    Text(conversation.lastMessage?.role == "user" ? "You:" : "AI:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .italic()
                    
                    Text(conversation.lastMessage?.content ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            Text(conversation.lastDateActivity.toFormat("HH:mm"))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        ConversationRowView(conversation: Conversation(
            id: UUID(),
            userId: UUID(),
            title: "Discussion de chose",
            featureName: "translation",
            createdAt: CreatedAtSupabase(Date().ISO8601Format())
        ))
    }
}
