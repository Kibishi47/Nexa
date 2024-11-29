//
//  ChatRepository.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import Foundation

struct ChatRepository {
    private let chats = [
        Chat(id: UUID(), title: "Discussion sur l'IA", lastMessage: "Fascinant ! Pouvez-vous m'en dire plus ?", date: Date()),
        Chat(id: UUID(), title: "Projet Nexa", lastMessage: "Quelles sont les prochaines étapes ?", date: Date().addingTimeInterval(-3600)),
        Chat(id: UUID(), title: "Brainstorming", lastMessage: "J'ai une idée pour améliorer l'interface.", date: Date().addingTimeInterval(-86400))
    ]
    
    func getChats() -> [Chat] {
        chats
    }
}
