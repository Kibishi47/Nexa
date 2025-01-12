//
//  Language.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 12/01/2025.
//

import Foundation

struct Language: Identifiable, Equatable {
    let id = UUID()
    let code: String // ex: "fr", "en"
    let region: String? // ex: "FR", "US"
    let name: String
    
    var flag: String {
        let base: UInt32 = 127397
        var flag = ""
        var countryCode = region ?? code.uppercased()
        if countryCode == "EN" {
            countryCode = "GB"
        }
        for scalar in countryCode.unicodeScalars {
            flag.append(String(UnicodeScalar(base + scalar.value)!))
        }
        return flag
    }
    
    static func == (lhs: Language, rhs: Language) -> Bool {
        return lhs.code == rhs.code
    }
}
