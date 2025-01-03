//
//  ProfileViewState.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

class ProfileViewState: ViewState {
    
    var navigationManager: NavigationManager
    
    init(_ navigationManager: NavigationManager) {
        self.navigationManager = navigationManager
        self.navigationManager.currentView = AnyView(ProfileView())
        self.navigationManager.currentMenuItem = .profile
    }
    
    func navigateBack() {
        navigationManager.navigateToMain()
    }
    
    func navigateToHome() {
        navigationManager.updateView(HomeViewState(navigationManager))
    }
    
    func navigateToLogin() {
        return
    }
    
    func navigateToSignUp() {
        return
    }
    
    func navigateToMain() {
        navigationManager.updateView(MainViewState(navigationManager))
    }
    
    func navigateToProfile() {
        return
    }
    
    func navigateToSubscription() {
        return
    }
    
    func navigateToHistory() {
        return
    }
    
    func navigateToConversationList(feature: AIFeature) {
        return
    }
    
    func navigateToConversation(conversation: Conversation?, feature: AIFeature) {
        return
    }
}
