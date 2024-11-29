//
//  LoginViewState.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

class LoginViewState: ViewState {
    
    var navigationManager: NavigationManager
    
    init(_ navigationManager: NavigationManager) {
        self.navigationManager = navigationManager
        self.navigationManager.currentView = AnyView(LoginView())
    }
    
    func navigateBack() {
        navigationManager.updateView(HomeViewState(navigationManager))
    }
    
    func navigateToHome() {
        navigationManager.updateView(HomeViewState(navigationManager))
    }
    
    func navigateToLogin() {
        return
    }
    
    func navigateToSignUp() {
        navigationManager.updateView(SignUpViewState(navigationManager))
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
