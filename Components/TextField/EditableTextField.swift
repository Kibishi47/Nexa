//
//  EditableTextField.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 13/12/2024.
//

import SwiftUI

struct EditableTextField: View {
    let placeholder: String
    let systemImage: String
    @Binding var text: String
    @Binding var isEditing: Bool
    let onSubmit: () -> Void
    
    @FocusState private var isFocused: Bool
    
    init(placeholder: String, systemImage: String, text: Binding<String>, isEditing: Binding<Bool>, onSubmit: @escaping () -> Void) {
        self.placeholder = placeholder
        self.systemImage = systemImage
        self._text = text
        self._isEditing = isEditing
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        ZStack {
            CustomTextField(
                placeholder: placeholder,
                systemImage: systemImage,
                isSecure: false,
                text: $text,
                autocapitalization: false,
                disabled: .constant(!isEditing)
            )
            .focused($isFocused)
            .onChange(of: isEditing) { newValue in
                if newValue {
                    isFocused = true
                }
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    if isEditing {
                        onSubmit()
                    }
                    isEditing.toggle()
                }) {
                    Image(systemName: isEditing ? "checkmark" : "pencil")
                        .foregroundColor(.blue)
                        .frame(width: 44, height: 44)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        EditableTextField(
            placeholder: "Username",
            systemImage: "person",
            text: .constant(""),
            isEditing: .constant(false)
        ) {
            
        }
    }
}

