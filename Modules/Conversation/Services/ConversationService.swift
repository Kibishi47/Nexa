//
//  ConversationService.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/01/2025.
//

import Foundation

class ConversationService {
    private static var instance: ConversationService? = nil
    
    private init() {}
    
    static func getInstance() -> ConversationService {
        if instance == nil {
            instance = ConversationService()
        }
        return instance!
    }
    
    func fetchConversations(userId: UUID, limit: Int? = nil) async -> [Conversation] {
        do {
            var query = supabaseClient
                .from("conversations_with_last_message")
                .select("*, messages(*)")
                .eq("user_id", value: userId)
                .order("last_message_date", ascending: false)
            
            if let limit = limit {
                query = query.limit(limit)
            }
            
            let conversations: [Conversation] = try await query.execute().value
            return conversations
        } catch {
            print("error fetching conversations: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchConversationsByFeature(userId: UUID, featureName: String) async -> [Conversation] {
        do {
            let conversations: [Conversation] = try await supabaseClient
                .from("conversations_with_last_message")
                .select("*, messages(*)")
                .eq("user_id", value: userId)
                .eq("feature_name", value: featureName)
                .order("last_message_date", ascending: false)
                .execute()
                .value
            return conversations
        } catch {
            print("error fetching conversations: \(error.localizedDescription)")
            return []
        }
    }
}
