//
//  NavigationManager.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

class NavigationManager: ObservableObject {
    @Published var currentView: AnyView = AnyView(HomeView())
    @Published var currentMenuItem: MenuItem = .main
    private lazy var viewState: ViewState = HomeViewState(self)
    
    func updateView(_ viewState: ViewState) {
        self.viewState = viewState
    }
    
    func navigateBack() {
        viewState.navigateBack()
    }
    
    func navigateToHome() {
        viewState.navigateToHome()
    }
    
    func navigateToLogin() {
        viewState.navigateToLogin()
    }
    
    func navigateToSignUp() {
        viewState.navigateToSignUp()
    }
    
    func navigateToMain() {
        viewState.navigateToMain()
    }
    
    func navigateToProfile() {
        viewState.navigateToProfile()
    }
    
    func navigateToSubscription() {
        viewState.navigateToSubscription()
    }
    
    func navigateToHistory() {
        viewState.navigateToHistory()
    }
    
    func navigateToChatList() {
        viewState.navigateToChatList()
    }
    
    func navigateToChat(id: UUID?) {
        viewState.navigateToChat(id: id)
    }
}
