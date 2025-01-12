//
//  MainViewState.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

class MainViewState: ViewState {
    
    var navigationManager: NavigationManager
    
    init(_ navigationManager: NavigationManager) {
        self.navigationManager = navigationManager
        self.navigationManager.currentView = AnyView(MainView())
        self.navigationManager.currentMenuItem = .main
    }
    
    func navigateBack() {
        return
    }
    
    func navigateToHome() {
        navigationManager.updateView(HomeViewState(navigationManager))
    }
    
    func navigateToLogin() {
        navigationManager.updateView(LoginViewState(navigationManager))
    }
    
    func navigateToSignUp() {
        navigationManager.updateView(SignUpViewState(navigationManager))
    }
    
    func navigateToMain() {
        return
    }
    
    func navigateToProfile() {
        navigationManager.updateView(ProfileViewState(navigationManager))
    }
    
    func navigateToSubscription() {
        navigationManager.updateView(SubscriptionViewState(navigationManager))
    }
    
    func navigateToHistory() {
        navigationManager.updateView(HistoryViewState(navigationManager))
    }
    
    func navigateToConversationList(feature: AIFeature) {
        navigationManager.updateView(ConversationListViewState(navigationManager, feature))
    }
    
    func navigateToConversation(conversation: Conversation?, feature: AIFeature) {
        navigationManager.updateView(ConversationViewState(navigationManager, conversation: conversation, feature: feature))
    }
}
