//
//  ConversationListViewModel.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/01/2025.
//

import Foundation

class ConversationListViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var conversations: [Conversation] = []
    let feature: AIFeature
    
    private let service = ConversationService.getInstance()
    private let dataManager = DataManager.getInstance()
    
    init(feature: AIFeature) {
        self.feature = feature
    }
    
    func fetchData() async {
        setIsLoading(true)
        if (await dataManager.fetchUserData()) {
            await self.setConversations(service.fetchConversationsByFeature(userId: dataManager.user!.id, featureName: feature.key))
        }
        setIsLoading(false)
    }
    
    private func setConversations(_ conversations: [Conversation]) {
        DispatchQueue.main.async {
            self.conversations = conversations
        }
    }
    
    private func setIsLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
        }
    }
}
