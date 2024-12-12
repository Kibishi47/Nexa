//
//  SubscriptionViewState.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

class ChatViewState: ViewState {
    
    var navigationManager: NavigationManager
    
    init(_ navigationManager: NavigationManager, id: UUID?) {
        self.navigationManager = navigationManager
        self.navigationManager.currentView = AnyView(ChatView(chatId: id))
        self.navigationManager.currentMenuItem = .main
    }
    
    func navigateBack() {
        navigationManager.navigateToChatList()
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
    
    func navigateToChatList() {
        navigationManager.updateView(ChatListViewState(navigationManager))
    }
    
    func navigateToChat(id: UUID?) {
        
    }
}
