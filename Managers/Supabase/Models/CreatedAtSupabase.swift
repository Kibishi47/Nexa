//
//  CreatedAtSupabase.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/01/2025.
//

import Foundation

struct CreatedAtSupabase: Codable, Equatable {
    private var value: String

    init(_ value: String) {
        self.value = value
    }

    func getValue() -> String {
        return value
    }

    func toDate() -> Date {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // Gère les fractions de secondes
        if let date = formatter.date(from: value) {
            return date
        } else {
            // Tentative avec un DateFormatter pour des formats légèrement différents
            let fallbackFormatter = DateFormatter()
            fallbackFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            fallbackFormatter.locale = Locale(identifier: "en_US_POSIX")
            fallbackFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            return fallbackFormatter.date(from: value) ?? Date()
        }
    }
    
    // MARK: - Codable Implementation
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try container.decode(String.self) // Décoder la chaîne brute
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value) // Encoder la chaîne brute
    }
}
