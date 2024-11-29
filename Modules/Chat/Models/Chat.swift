//
//  Conversation.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//


import Foundation

struct Chat: Identifiable {
    let id: UUID
    let title: String
    let lastMessage: String
    let date: Date
}
