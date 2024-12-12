//
//  SignUpView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @StateObject private var viewModel = SignUpViewModel()
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 25) {
            
            BackButton()
            
            Spacer()
            
            VStack(spacing: 25) {
                // Logo & title
                VStack(spacing: 15) {
                    AIMascot()
                        .frame(width: 100, height: 100)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                    
                    Text("Inscription")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(isAnimating ? 1 : 0)
                }
                
                // Form fields
                VStack(spacing: 20) {
                    CustomTextField(
                        placeholder: "Nom complet",
                        systemImage: "person",
                        isSecure: false,
                        text: $viewModel.username
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    
                    CustomTextField(
                        placeholder: "Email",
                        systemImage: "envelope",
                        isSecure: false,
                        text: $viewModel.email,
                        autocapitalization: false
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    
                    CustomTextField(
                        placeholder: "Mot de passe",
                        systemImage: "lock",
                        isSecure: true,
                        text: $viewModel.password
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    
                    CustomTextField(
                        placeholder: "Confirmer le mot de passe",
                        systemImage: "lock",
                        isSecure: true,
                        text: $viewModel.confirmPassword
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                }
                .padding(.top, 30)
                
                // Error message display
                if !viewModel.registerErrorMessage.isEmpty {
                    Text(viewModel.registerErrorMessage)
                        .foregroundColor(.red)
                        .opacity(isAnimating ? 1 : 0)
                }
                
                // Registration button
                PrimaryButton(title: "S'inscrire", isLoading: $viewModel.isLoading) {
                    Task {
                        await viewModel.register()
                    }
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                
                // Link to connection
                Button(action: {
                    navigationManager.navigateToLogin()
                }) {
                    Text("Déjà un compte ? Se connecter")
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
    SignUpView()
        .environmentObject(NavigationManager())
}
