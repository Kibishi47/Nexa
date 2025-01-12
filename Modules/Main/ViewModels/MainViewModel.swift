//
//  MainViewModel.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 12/01/2025.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var isLoading: Bool = true
    @Published var searchText: String = ""
    
    private let service = ConversationService.getInstance()
    private let dataManager = DataManager.getInstance()
    
    init() {}
    
    func fetchData() async {
        setIsLoading(true)
        if (await dataManager.fetchUserData()) {
            await self.setConversations(service.fetchConversations(userId: dataManager.user!.id, limit: 3))
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
