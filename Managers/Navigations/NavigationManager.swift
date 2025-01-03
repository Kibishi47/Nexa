//
//  NavigationManager.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

class NavigationManager: ObservableObject, AuthService.Observer {
    @Published var currentView: AnyView = AnyView(HomeView())
    @Published var currentMenuItem: MenuItem = .main
    private lazy var viewState: ViewState = HomeViewState(self)
    
    private let authService = AuthService.getInstance()
    
    init() {
        authService.subscribe(self)
        initiateView()
    }
    
    private func initiateView() {
        if (authService.isAuthenticated()) {
            self.viewState.navigateToMain()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func updateView(_ viewState: ViewState) {
        self.viewState = viewState
    }
    
    func navigateBack() {
        viewState.navigateBack()
    }
    
    func navigateToHome() {
        if (authService.isAuthenticated()) {
            self.viewState.navigateToMain()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToLogin() {
        if (authService.isAuthenticated()) {
            self.viewState.navigateToMain()
        } else {
            self.viewState.navigateToLogin()
        }
    }
    
    func navigateToSignUp() {
        if (authService.isAuthenticated()) {
            self.viewState.navigateToMain()
        } else {
            self.viewState.navigateToSignUp()
        }
    }
    
    func navigateToMain() {
        if (authService.isAuthenticated()) {
            self.viewState.navigateToMain()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToProfile() {
        if (authService.isAuthenticated()) {
            self.viewState.navigateToProfile()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToSubscription() {
        if (authService.isAuthenticated()) {
            self.viewState.navigateToSubscription()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToHistory() {
        if (authService.isAuthenticated()) {
            self.viewState.navigateToHistory()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToConversationList(feature: AIFeature) {
        if (authService.isAuthenticated()) {
            self.viewState.navigateToConversationList(feature: feature)
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToConversation(conversation: Conversation?, feature: AIFeature) {
        if (authService.isAuthenticated()) {
            self.viewState.navigateToConversation(conversation: conversation, feature: feature)
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func onAuthStateChange(_ state: AuthService.AuthState) {
        switch state {
        case .loggedIn:
            navigateToMain()
        case .loggedOut:
            navigateToHome()
        }
    }
}
