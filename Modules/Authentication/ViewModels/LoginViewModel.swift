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
    
    let authService: AuthService = AuthService.instance
    
    func login() async {
        self.setIsLoading(true)
        if (checkFields()) {
            await authService.login(email: email, password: password) {[weak self] success, error in
                guard let self = self else { return }
                if (!success) {
                    if (error == nil) {
                        self.setLoginErrorMessage("An error occurred, please try again later")
                    } else {
                        self.setLoginErrorMessage(error!.localizedDescriptionInFrench)
                    }
                }
                self.setIsLoading(false)
            }
        } else {
            self.setLoginErrorMessage("Some fields are invalid")
            self.setIsLoading(false)
        }
    }
    
    private func checkFields() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    private func setLoginErrorMessage(_ message: String = "") {
        DispatchQueue.main.async {
            self.loginErrorMessage = message
        }
    }
    
    private func setIsLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = loading
        }
    }
}
