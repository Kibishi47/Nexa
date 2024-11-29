//
//  ProfileView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @State private var fullName = "John Doe"
    @State private var email = "john.doe@example.com"
    @State private var isEditingName = false
    @State private var isEditingEmail = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                NavigateBackHeader(title: "Profil")
                .padding(.horizontal)
                .padding(.bottom)
                
                // Profile Picture Section
                VStack(spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 110, height: 110)
                        )
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue, .purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                                .frame(width: 110, height: 110)
                        )
                }
                .padding(.bottom, 8)
                
                // Info Section
                VStack(spacing: 16) {
                    // Name Field
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Nom complet")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 4)
                        
                        HStack {
                            if isEditingName {
                                CustomTextField(
                                    placeholder: "Nom complet",
                                    systemImage: "person",
                                    isSecure: false,
                                    text: $fullName
                                )
                            } else {
                                Text(fullName)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 4)
                            }
                            
                            Spacer()
                            
                            Button(action: { isEditingName.toggle() }) {
                                Text(isEditingName ? "Enregistrer" : "Modifier")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                    }
                    
                    // Email Field
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Email")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 4)
                        
                        HStack {
                            if isEditingEmail {
                                CustomTextField(
                                    placeholder: "Email",
                                    systemImage: "envelope",
                                    isSecure: false,
                                    text: $email
                                )
                            } else {
                                Text(email)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 4)
                            }
                            
                            Spacer()
                            
                            Button(action: { isEditingEmail.toggle() }) {
                                Text(isEditingEmail ? "Enregistrer" : "Modifier")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                // Actions Section
                VStack(spacing: 16) {
                    // Change Password Button
                    PrimaryButton(title: "Changer le mot de passe") {
                        // Action to change password
                    }
                    
                    // Logout Button
                    Button(action: {
                        // Action to logout
                    }) {
                        Text("Déconnexion")
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.05))
                            )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .padding(.vertical)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
        .navigationBarHidden(true)
    }
}

#Preview {
    ProfileView()
        .environmentObject(NavigationManager())
}

