//
//  SecondaryButton.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 13/12/2024.
//


import SwiftUI

struct SecondaryButton: View {
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
                    .fill(Color.white.opacity(0.1))
            )
            .scaleEffect(isPressed ? 0.95 : 1)
        }
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        VStack(spacing: 20) {
            SecondaryButton(title: "Secondary") {}
            SecondaryButton(title: "Secondary", isLoading: .constant(true)) {}
        }
        .padding()
    }
}
