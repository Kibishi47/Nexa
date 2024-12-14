//
//  User.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/12/2024.
//

import Foundation

struct Profile: Codable {
    let id: UUID
    let userId: UUID
    var username: String
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case username
        case avatarUrl = "avatar_url"
    }
}
