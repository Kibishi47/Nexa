//
//  SideMenu.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct SideMenu: View {
    @Binding var isShowing: Bool
    @EnvironmentObject private var navigationManager: NavigationManager
    let menuItems: [MenuItem] = [.main, .profile, .subscription, .history, .logout]
    
    var body: some View {
        ZStack {
            // Semi-transparent background
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            isShowing = false
                        }
                    }
            }
            
            // Menu
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    // Menu header
                    VStack(alignment: .leading, spacing: 16) {
                        AIMascot()
                            .frame(width: 60, height: 60)
                            .padding(.bottom, 50)
                        
                        Text("Nexa")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 24)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.6))
                    
                    // List of items
                    ForEach(menuItems) { item in
                        Button(action: {
                            handleMenuItemTap(item)
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: item.icon)
                                    .font(.system(size: 20))
                                Text(item.rawValue)
                                    .font(.body)
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                navigationManager.currentMenuItem == item ?
                                Color.white.opacity(0.1) : Color.clear
                            )
                        }
                    }
                    
                    Spacer()
                }
                .frame(width: 270)
                .background(Color.black)
                .offset(x: isShowing ? 0 : -270)
                
                Spacer()
            }
        }
        .animation(.easeOut, value: isShowing)
    }
    
    private func handleMenuItemTap(_ item: MenuItem) {
        withAnimation(.easeOut) {
            isShowing = false
        }
        
        switch item {
        case .main:
            navigationManager.navigateToMain()
        case .profile:
            navigationManager.navigateToProfile()
        case .subscription:
            navigationManager.navigateToSubscription()
        case .history:
            navigationManager.navigateToHistory()
        case .logout:
            Task {
                await AuthService.getInstance().logout(){ success, error in
                    if (!success) {
                        // TODO: Inform user
                    }
                }
            }
        }
    }
}

#Preview {
    SideMenu(isShowing: .constant(true))
        .environmentObject(NavigationManager())
}
