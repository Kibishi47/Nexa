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
        if (checkFields()) {
            await authService.register(email: email, password: password, username: username) {[weak self] success, error in
                guard let self = self else { return }
                if (!success) {
                    if (error == nil) {
                        self.setRegisterErrorMessage("An error occurred, please try again later")
                    } else {
                        self.setRegisterErrorMessage(error!.localizedDescriptionInFrench)
                    }
                }
                self.setIsLoading(false)
            }
        } else {
            setRegisterErrorMessage("Some fields are invalid")
            self.setIsLoading(false)
        }
    }
    
    private func checkFields() -> Bool {
        return !email.isEmpty && !password.isEmpty && !username.isEmpty && password == confirmPassword
    }
    
    private func setRegisterErrorMessage(_ message: String = "") {
        DispatchQueue.main.async {
            self.registerErrorMessage = message
        }
    }
    
    private func setIsLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = loading
        }
    }
}
