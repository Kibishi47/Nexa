//
//  SubscriptionViewState.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

class ConversationViewState: ViewState {
    
    var navigationManager: NavigationManager
    private let feature: AIFeature
    
    init(_ navigationManager: NavigationManager, conversation: Conversation?, feature: AIFeature) {
        self.navigationManager = navigationManager
        self.navigationManager.currentView = AnyView(ConversationView(conversation: conversation, feature: feature))
        self.navigationManager.currentMenuItem = .main
        self.feature = feature
    }
    
    func navigateBack() {
        navigationManager.navigateToConversationList(feature: feature)
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
        navigationManager.updateView(ConversationListViewState(navigationManager, feature))
    }
    
    func navigateToConversation(conversation: Conversation?, feature: AIFeature) {
        return
    }
}
