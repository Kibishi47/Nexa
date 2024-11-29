//
//  PrimaryButton.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                    isPressed = false
                }
            }
            
            action()
        }) {
            Text(title)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.black)
                .frame(width: 200, height: 50)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                        
                        // Gloss effect
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.white.opacity(0.2), Color.white.opacity(0)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        // Border
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    }
                )
                .shadow(color: .white.opacity(0.2), radius: 10, x: 0, y: 5)
                .scaleEffect(isPressed ? 0.95 : 1)
        }
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        PrimaryButton(title: "Aperçu", action: {})
    }
}
