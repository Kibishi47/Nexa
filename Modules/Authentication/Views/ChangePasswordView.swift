//
//  ChangePasswordView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 13/12/2024.
//

import SwiftUI

struct ChangePasswordView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmNewPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 24) {
            // Header with close button
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding()
            
            // Title
            Text("Changer le mot de passe")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            // Password fields
            VStack(spacing: 16) {
                CustomTextField(
                    placeholder: "Mot de passe actuel",
                    systemImage: "lock",
                    isSecure: true,
                    text: $currentPassword
                )
                
                CustomTextField(
                    placeholder: "Nouveau mot de passe",
                    systemImage: "lock.rotation",
                    isSecure: true,
                    text: $newPassword
                )
                
                CustomTextField(
                    placeholder: "Confirmer le nouveau mot de passe",
                    systemImage: "lock.rotation",
                    isSecure: true,
                    text: $confirmNewPassword
                )
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Change password button
            SuccessButton(
                title: "Changer le mot de passe",
                isLoading: $isLoading
            ) {
                isLoading = true
                if newPassword == confirmNewPassword {
                    viewModel.changePassword()
                } else {
                    isLoading = false
                    alertMessage = "Les nouveaux mots de passe ne correspondent pas"
                    showAlert = true
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Information"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if alertMessage == "Mot de passe changé avec succès" {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        ChangePasswordView(viewModel: ProfileViewModel())
    }
}

