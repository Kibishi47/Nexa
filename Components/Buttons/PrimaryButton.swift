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
    @Binding var isLoading: Bool
    @State private var isPressed = false
    
    init(title: String, isLoading: Binding<Bool> = .constant(false), action: @escaping () -> Void) {
        self.title = title
        self._isLoading = isLoading
        self.action = action
    }

    var body: some View {
        Button(action: {
            isPressed = true
            if isLoading == false {
                action()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isPressed = false
            }
        }) {
            ZStack {
                Text(title)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.black)
                    .opacity(isLoading ? 0 : 1)
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                }
            }
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
        VStack(spacing: 20) {
            PrimaryButton(title: "Aperçu") {}
            PrimaryButton(title: "Aperçu", isLoading: .constant(true)) {}
        }
        .padding()
    }
}
