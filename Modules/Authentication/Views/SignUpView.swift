//
//  SignUpView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 25) {
            
            BackButton()
            
            Spacer()
            
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
                    text: $fullName
                )
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                
                CustomTextField(
                    placeholder: "Email",
                    systemImage: "envelope",
                    isSecure: false,
                    text: $email
                )
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                
                CustomTextField(
                    placeholder: "Mot de passe",
                    systemImage: "lock",
                    isSecure: true,
                    text: $password
                )
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                
                CustomTextField(
                    placeholder: "Confirmer le mot de passe",
                    systemImage: "lock",
                    isSecure: true,
                    text: $confirmPassword
                )
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
            }
            .padding(.top, 30)
            
            // Registration button
            PrimaryButton(title: "S'inscrire") {
                // TODO: To implement
                navigationManager.navigateToMain()
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
