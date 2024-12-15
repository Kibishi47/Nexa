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
            Text("change_password_title".translate(moduleName: "Authentication"))
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            // Password fields
            VStack(spacing: 16) {
                CustomTextField(
                    placeholder: "actual_password".translate(moduleName: "Authentication"),
                    systemImage: "lock",
                    isSecure: true,
                    text: $viewModel.oldPassword
                )
                
                CustomTextField(
                    placeholder: "new_password".translate(moduleName: "Authentication"),
                    systemImage: "lock.rotation",
                    isSecure: true,
                    text: $viewModel.newPassword
                )
                
                CustomTextField(
                    placeholder: "confirm_new_password".translate(moduleName: "Authentication"),
                    systemImage: "lock.rotation",
                    isSecure: true,
                    text: $viewModel.confirmPassword
                )
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Change password button
            SuccessButton(
                title: "change_password_action".translate(moduleName: "Authentication"),
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
                title: Text("alert_error_title".translate(moduleName: "Authentication")),
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

