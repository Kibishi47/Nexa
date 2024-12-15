//
//  AuthViewModel.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 11/12/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    @Published var loginErrorMessage: String = ""
    
    let authService: AuthService = AuthService.getInstance()
    
    func login() async {
        self.setIsLoading(true)
        if (checkFields()) {
            await authService.login(email: email, password: password) {[weak self] success, error in
                guard let self = self else { return }
                if (!success) {
                    self.setLoginErrorMessage(error)
                }
                self.setIsLoading(false)
            }
        } else {
            self.setLoginErrorMessage(NexaError.emptyFields)
            self.setIsLoading(false)
        }
    }
    
    private func checkFields() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    private func setLoginErrorMessage(_ error: NexaError?) {
        DispatchQueue.main.async {
            if let error = error {
                self.loginErrorMessage = error.description
            } else {
                self.loginErrorMessage = NexaError.unknownError.description
            }
        }
    }
    
    private func setIsLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = loading
        }
    }
}
