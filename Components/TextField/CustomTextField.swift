//
//  CustomTextField.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    let systemImage: String
    let isSecure: Bool
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(.white.opacity(0.7))
                .frame(width: 20)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textContentType(.password)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
    }
}

#Preview {
    CustomTextField(
        placeholder: "Username",
        systemImage: "person",
        isSecure: false,
        text: .constant("")
    )
}
