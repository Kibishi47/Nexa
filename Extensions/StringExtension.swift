//
//  StringExtensions.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 15/12/2024.
//

import Foundation

extension String {
    func translate(moduleName: String = "Nexa") -> String {
        return NSLocalizedString(self, tableName: moduleName, comment: "")
    }
}
