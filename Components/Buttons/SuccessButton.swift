//
//  SuccessButton.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 13/12/2024.
//


import SwiftUI

struct SuccessButton: View {
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
            if !isLoading {
                action()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
            }
        }) {
            ZStack {
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(isLoading ? 0 : 1)
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
        }
        .scaleEffect(isPressed ? 0.98 : 1)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        VStack(spacing: 20) {
            SuccessButton(title: "Confirmer") {}
            SuccessButton(title: "Chargement", isLoading: .constant(true)) {}
        }
        .padding()
    }
}

