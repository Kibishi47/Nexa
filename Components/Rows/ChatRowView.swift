//
//  ChatRowView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct ChatRowView: View {
    let chat: Chat
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "bubble.left.and.bubble.right.fill")
                .font(.system(size: 40))
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(chat.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(chat.lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Text(formatDate(chat.date))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(12)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        ChatRowView(chat: Chat(id: UUID(), title: "Discussion sur l'IA", lastMessage: "Fascinant ! Pouvez-vous m'en dire plus ?", date: Date()))
    }
}
