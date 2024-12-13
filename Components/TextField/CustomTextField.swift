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
    let autocapitalization: Bool
    @Binding var disabled: Bool

    init(
        placeholder: String,
        systemImage: String,
        isSecure: Bool,
        text: Binding<String>,
        autocapitalization: Bool = true,
        disabled: Binding<Bool> = .constant(false),
        enabled: Binding<Bool> = .constant(true)
    ) {
        self.placeholder = placeholder
        self.systemImage = systemImage
        self.isSecure = isSecure
        self._text = text
        self.autocapitalization = autocapitalization
        self._disabled = Binding(
            get: { !enabled.wrappedValue || disabled.wrappedValue },
            set: { newValue in
                disabled.wrappedValue = newValue
                enabled.wrappedValue = !newValue
            })
    }

    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(.white.opacity(0.7))
                .frame(width: 20)

            if isSecure {
                SecureField(placeholder, text: $text)
                    .textContentType(.password)
                    .disabled(disabled)
            } else {
                TextField(placeholder, text: $text)
                    .autocapitalization(autocapitalization ? .sentences : .none)
                    .disabled(disabled)
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
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        CustomTextField(
            placeholder: "Username",
            systemImage: "person",
            isSecure: false,
            text: .constant("")
        )
    }
}
