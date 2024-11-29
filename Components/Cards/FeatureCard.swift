//
//  FeatureCard.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct FeatureCard: View {
    let feature: AIFeature
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: feature.icon)
                        .font(.system(size: 24))
                        .foregroundColor(feature.color)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
                
                Text(feature.rawValue)
                    .font(.headline)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
            }
        }
        .frame(height: 80, alignment: .top)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(feature.color.opacity(0.15))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(feature.color.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        FeatureCard(feature: .chat)
    }
}
