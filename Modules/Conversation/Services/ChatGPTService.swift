//
//  ChatService.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 03/01/2025.
//

import Foundation

class ChatGPTService {
    private static var instance: ChatGPTService? = nil
    
    private let stringUrl: String
    
    private init() {
        stringUrl = chatGPTURL
    }
    
    static func getInstance() -> ChatGPTService {
        if instance == nil {
            instance = ChatGPTService()
        }
        return instance!
    }
    
    func send(url: String, data: [String: String]) async -> [String: Any] {
        do {
            let response = try await APIService.request(
                url: self.stringUrl + url,
                method: .post,
                body: data
            )
            return response
        } catch {
            print("error sending data to chagpt: \(error.localizedDescription)")
            return [
                "error": error.localizedDescription
            ]
        }
    }
}
