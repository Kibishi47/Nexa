//
//  HistoryViewState.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

class HistoryViewState: ViewState {
    
    var navigationManager: NavigationManager
    
    init(_ navigationManager: NavigationManager) {
        self.navigationManager = navigationManager
        self.navigationManager.currentView = AnyView(HistoryView())
        self.navigationManager.currentMenuItem = .history
    }
    
    func navigateBack() {
        navigationManager.updateView(MainViewState(navigationManager))
    }
    
    func navigateToHome() {
        return
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
        return
    }
    
    func navigateToChat(id: UUID?) {
        return
    }
}
