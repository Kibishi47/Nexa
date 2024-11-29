//
//  HistoryItem.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct HistoryRow: View {
    let item: HistoryItem
    
    var body: some View {
        HStack {
            Image(systemName: item.type.icon)
                .foregroundColor(item.type.color)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(item.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(10)
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        HistoryRow(item: HistoryItem(title: "Conversation sur l'IA", date: "28 Nov", type: .chat))
    }
}
