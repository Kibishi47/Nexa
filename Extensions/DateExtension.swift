//
//  DateExtension.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 15/12/2024.
//

import Foundation

extension Date {
    func toFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
