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
    
    init() {
        AuthService.instance.subscribe(self)
        
        // Go to the first page depending on connection
        if (AuthService.instance.isAuthenticated()) {
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
        if (AuthService.instance.isAuthenticated()) {
            self.viewState.navigateToMain()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToLogin() {
        if (AuthService.instance.isAuthenticated()) {
            self.viewState.navigateToMain()
        } else {
            self.viewState.navigateToLogin()
        }
    }
    
    func navigateToSignUp() {
        if (AuthService.instance.isAuthenticated()) {
            self.viewState.navigateToMain()
        } else {
            self.viewState.navigateToSignUp()
        }
    }
    
    func navigateToMain() {
        if (AuthService.instance.isAuthenticated()) {
            self.viewState.navigateToMain()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToProfile() {
        if (AuthService.instance.isAuthenticated()) {
            self.viewState.navigateToProfile()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToSubscription() {
        if (AuthService.instance.isAuthenticated()) {
            self.viewState.navigateToSubscription()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToHistory() {
        if (AuthService.instance.isAuthenticated()) {
            self.viewState.navigateToHistory()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToChatList() {
        if (AuthService.instance.isAuthenticated()) {
            self.viewState.navigateToChatList()
        } else {
            self.viewState.navigateToHome()
        }
    }
    
    func navigateToChat(id: UUID?) {
        if (AuthService.instance.isAuthenticated()) {
            self.viewState.navigateToChat(id: id)
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
