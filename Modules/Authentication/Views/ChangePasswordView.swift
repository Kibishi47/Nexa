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
                    text: $viewModel.oldPassword
                )
                
                CustomTextField(
                    placeholder: "Nouveau mot de passe",
                    systemImage: "lock.rotation",
                    isSecure: true,
                    text: $viewModel.newPassword
                )
                
                CustomTextField(
                    placeholder: "Confirmer le nouveau mot de passe",
                    systemImage: "lock.rotation",
                    isSecure: true,
                    text: $viewModel.confirmPassword
                )
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Change password button
            SuccessButton(
                title: "Changer le mot de passe",
                isLoading: $viewModel.isPasswordLoading
            ) {
                Task {
                    await viewModel.updatePassword()
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
        .alert(isPresented: $viewModel.isShowingPasswordAlert) {
            Alert(
                title: Text("Erreur"),
                message: Text(viewModel.passwordError),
                dismissButton: .default(Text("OK"))
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

