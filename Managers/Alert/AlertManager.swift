//
//  ErrorManager.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 14/12/2024.
//

import Foundation

class AlertManager: ObservableObject {
    @Published var success: Bool = true
    @Published var presented: Bool = false
    @Published var title: String = ""
    @Published var message: String = ""
    
    func setSuccess(_ message: String) {
        self.title = "success".translate()
        self.message = message
        self.success = true
        self.presented = true
    }
    
    func setError(_ message: String) {
        self.title = "error".translate()
        self.message = message
        self.success = false
        self.presented = true
    }
}
