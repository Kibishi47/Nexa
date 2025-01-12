//
//  LoginView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @StateObject private var viewModel = LoginViewModel()
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                BackButton()
                Spacer()
            }
            
            Spacer()
            
            // Main content
            VStack(spacing: 25) {
                // Logo and title
                VStack(spacing: 15) {
                    AIMascot()
                        .frame(width: 100, height: 100)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                    
                    Text("connection_title".translate(moduleName: "Authentication"))
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(isAnimating ? 1 : 0)
                }
                .padding(.top, 20)
                
                // Form fields
                VStack(spacing: 20) {
                    CustomTextField(
                        placeholder: "email_field".translate(moduleName: "Authentication"),
                        systemImage: "envelope",
                        isSecure: false,
                        text: $viewModel.email,
                        autocapitalization: false
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    
                    CustomTextField(
                        placeholder: "password_field".translate(moduleName: "Authentication"),
                        systemImage: "lock",
                        isSecure: true,
                        text: $viewModel.password
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                }
                .padding(.top, 30)
                
                // Error message display
                if !viewModel.loginErrorMessage.isEmpty {
                    Text(viewModel.loginErrorMessage)
                        .foregroundColor(.red)
                        .opacity(isAnimating ? 1 : 0)
                }
                
                // Connection button
                PrimaryButton(title: "connect_action".translate(moduleName: "Authentication"), isLoading: $viewModel.isLoading) {
                    Task {
                        await viewModel.login()
                    }
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                
                // Link to registration
                Button(action: {
                    navigationManager.navigateToSignUp()
                }) {
                    Text("no_account_yet".translate(moduleName: "Authentication"))
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                }
                .opacity(isAnimating ? 1 : 0)
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isAnimating = true
            }
        }
    }
}
#Preview {
    LoginView()
        .environmentObject(NavigationManager())
}
