//
//  SubscriptionViewState.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

class ConversationListViewState: ViewState {
    
    var navigationManager: NavigationManager
    
    init(_ navigationManager: NavigationManager, _ feature: AIFeature) {
        self.navigationManager = navigationManager
        self.navigationManager.currentView = AnyView(ConversationListView(feature: feature))
        self.navigationManager.currentMenuItem = .main
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
        navigationManager.updateView(ConversationViewState(navigationManager, conversation: conversation, feature: feature))
    }
}
