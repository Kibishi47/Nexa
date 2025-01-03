//
//  ChatRowView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct NewConversationRowView: View {
    let feature: AIFeature
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(feature.color.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(feature.color)
            }
            
            Text("Nouvelle conversation")
                .font(.headline)
                .foregroundColor(feature.color)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
        }
        .padding()
        .background(feature.color.opacity(0.05))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(feature.color.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        NewConversationRowView(feature: .translation)
            .padding()
    }
}

