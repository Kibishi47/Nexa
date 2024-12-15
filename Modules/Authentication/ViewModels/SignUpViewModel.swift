//
//  AuthViewModel.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/12/2024.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var username: String = ""
    
    @Published var isLoading: Bool = false
    @Published var registerErrorMessage: String = ""
    
    let authService: AuthService = AuthService.getInstance()
    
    func register() async {
        self.setIsLoading(true)
        
        guard !email.isEmpty, !password.isEmpty else {
            setRegisterErrorMessage(NexaError.emptyFields)
            self.setIsLoading(false)
            return
        }
        guard password == confirmPassword else {
            setRegisterErrorMessage(NexaError.invalidConfirmPassword)
            self.setIsLoading(false)
            return
        }
        
        await authService.register(email: email, password: password, username: username) {[weak self] success, error in
            guard let self = self else { return }
            if (!success) {
                self.setRegisterErrorMessage(error)
            }
            self.setIsLoading(false)
        }
    }
    
    private func checkFields() -> Bool {
        return !email.isEmpty && !password.isEmpty && !username.isEmpty && password == confirmPassword
    }
    
    private func setRegisterErrorMessage(_ error: NexaError?) {
        DispatchQueue.main.async {
            if let error = error {
                self.registerErrorMessage = error.description
            } else {
                self.registerErrorMessage = NexaError.unknownError.description
            }
        }
    }
    
    private func setIsLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = loading
        }
    }
}
