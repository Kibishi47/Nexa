//
//  ViewState.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import Foundation

protocol ViewState {
    func navigateBack()
    func navigateToHome()
    func navigateToLogin()
    func navigateToSignUp()
    func navigateToMain()
    func navigateToProfile()
    func navigateToSubscription()
    func navigateToHistory()
    func navigateToConversationList(feature: AIFeature)
    func navigateToConversation(conversation: Conversation?, feature: AIFeature)
}
