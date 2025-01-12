//
//  HistoryViewModel.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/01/2025.
//

import Foundation

class HistoryViewModel: ObservableObject {
    private var conversations: [Conversation] = []
    var filteredConversation: [Conversation] {
        if (searchText.isEmpty) {
            return conversations
        }
        return conversations.filter {
            $0.messages.contains {
                $0.content.lowercased().contains(searchText.lowercased())
            } || $0.title.lowercased().contains(searchText.lowercased())
        }
    }
    @Published var isLoading: Bool = true
    @Published var searchText: String = ""
    
    private let service = ConversationService.getInstance()
    private let dataManager = DataManager.getInstance()
    
    init() {}
    
    func fetchData() async {
        setIsLoading(true)
        if (await dataManager.fetchUserData()) {
            await self.setConversations(service.fetchConversations(userId: dataManager.user!.id))
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
