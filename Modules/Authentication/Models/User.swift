//
//  User.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/12/2024.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    let username: String
    let email: String
    let password: String
    let createdAt: Date
}
