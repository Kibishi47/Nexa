//
//  HomeView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    
    @State private var isAnimating = false
    @State private var showText = false
    @State private var showButton = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Mascot
                AIMascot()
                    .frame(width: 200, height: 200)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1 : 0.5)
                    .offset(y: isAnimating ? 0 : 50)
                
                // Title & description
                if showText {
                    Text("Nexa")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    
                    Text("Ton assistant IA, au quotidien")
                        .font(.system(size: 20, weight: .light, design: .rounded))
                        .foregroundColor(.gray)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
                
                // Start button
                if showButton {
                    PrimaryButton(title: "Commencer") {
                        if isFirstLaunch {
                            navigationManager.navigateToSignUp()
                            isFirstLaunch = false
                        } else {
                            navigationManager.navigateToLogin()
                        }
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding()
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7, blendDuration: 0)) {
                isAnimating = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeOut(duration: 0.5)) {
                    showText = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0)) {
                    showButton = true
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(NavigationManager())
}
