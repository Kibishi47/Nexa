//
//  ProfileViewModel.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 12/12/2024.
//

import Foundation
import Supabase

class ProfileViewModel: ObservableObject {
    // Models
    @Published var profile: Profile?
    @Published var user: Supabase.User?
    
    // Change password
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var passwordError: String = ""
    
    // State variables
    @Published var isUsernameEditing = false {
        didSet {
            if isUsernameEditing == true && isEmailEditing == true {
                isEmailEditing = false
            }
        }
    }
    @Published var isEmailEditing = false {
        didSet {
            if isEmailEditing == true && isUsernameEditing == true {
                isUsernameEditing = false
            }
        }
    }
    
    // Loading variables
    @Published var isLoading = true
    @Published var isUpdating = false
    @Published var isPasswordLoading = false
    @Published var isLogoutLoading = false
    
    // Showing variables
    @Published var isShowingChangePassword = false
    @Published var isShowingImagePicker = false
    @Published var isShowingPasswordAlert = false
    
    // Services
    private let authService = AuthService.getInstance()
    private let profileService = ProfileService.getInstance()
    
    // Managers
    private var alertManager: AlertManager?
    private var dataManager = DataManager.getInstance()
    
    func setup(_ alertManager: AlertManager) {
        self.alertManager = alertManager
    }
    
    func fetchData() async {
        setIsLoading(true)
        if dataManager.user == nil || dataManager.profile == nil {
            if await !dataManager.fetchUserData() {
                setErrorMessage(NexaError.failToFetchData)
            }
        }
        getUserData()
        setIsLoading(false)
    }
    
    private func getUserData() {
        DispatchQueue.main.async {
            self.user = self.dataManager.user
            self.profile = self.dataManager.profile
        }
    }
    
    private func setUserData() {
        DispatchQueue.main.async {
            self.dataManager.user = self.user
            self.dataManager.profile = self.profile
        }
    }
    
    func updateUsername() async {
        setIsUpdating(true)
        if let profile = self.profile {
            await profileService.updateUsernameProfile(profile) {[weak self] success, error in
                guard let self = self else { return }
                if success {
                    setUserData()
                    self.setSuccessMessage("alert_success_change_username".translate(moduleName: "Authentication"))
                } else {
                    self.setErrorMessage(error)
                }
            }
        }
        setIsUpdating(false)
    }
    
    func updateEmail() async {
        setIsUpdating(true)
        if let user = self.user {
            await authService.updateUserEmail(user: user) {[weak self] success, error in
                guard let self = self else { return }
                if success {
                    setUserData()
                    self.setSuccessMessage("alert_success_confirmation_email".translate(moduleName: "Authentication"))
                } else {
                    self.setErrorMessage(error)
                }
            }
        }
        setIsUpdating(false)
    }
    
    func updatePassword() async {
        setIsPasswordLoading(true)
        if let user = user {
            guard !oldPassword.isEmpty, !newPassword.isEmpty, !confirmPassword.isEmpty else {
                setPasswordError(NexaError.emptyFields)
                setIsPasswordLoading(false)
                return
            }
            guard newPassword == confirmPassword else {
                setPasswordError(NexaError.invalidConfirmPassword)
                setIsPasswordLoading(false)
                return
            }
            
            var isGoodPassword = false
            
            await authService.login(email: user.email!, password: oldPassword, blockingNotify: true) {[weak self] success, error in
                guard let self = self else { return }
                if success {
                    isGoodPassword = true
                } else {
                    self.setPasswordError(error)
                }
            }
            
            if isGoodPassword {
                await authService.updateUserPassword(password: newPassword) {[weak self] success, error in
                    guard let self = self else { return }
                    if success {
                        self.setUserData()
                        self.passwordValidated()
                    } else {
                        self.setPasswordError(error)
                    }
                }
            }
            
        } else {
            setPasswordError(NexaError.failToFetchData)
        }
        setIsPasswordLoading(false)
    }
    
    func logout() async {
        self.setIsLogoutLoading(true)
        await authService.logout() { success, error in
            self.setIsLogoutLoading(false)
            if (!success) {
                self.setErrorMessage(error)
            }
        }
    }
    
    private func setIsLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
        }
    }
    
    private func setIsUpdating(_ isUpdating: Bool) {
        DispatchQueue.main.async {
            self.isUpdating = isUpdating
        }
    }
    
    private func setIsPasswordLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isPasswordLoading = isLoading
        }
    }
    
    private func setIsLogoutLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLogoutLoading = isLoading
        }
    }
    
    private func setSuccessMessage(_ message: String) {
        DispatchQueue.main.async {
            self.alertManager?.setSuccess(message)
        }
    }
    
    private func setErrorMessage(_ error: NexaError?) {
        DispatchQueue.main.async {
            if let error = error {
                self.alertManager?.setError(error.description)
            } else {
                self.alertManager?.setError(NexaError.unknownError.description)
            }
        }
    }
    
    private func passwordValidated() {
        DispatchQueue.main.async {
            self.isShowingChangePassword = false
            self.isPasswordLoading = false
            self.oldPassword = ""
            self.newPassword = ""
            self.confirmPassword = ""
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
            self.setSuccessMessage("alert_success_change_password".translate(moduleName: "Authentication"))
        }
    }
    
    private func setPasswordError(_ error: NexaError?) {
        DispatchQueue.main.async {
            self.isShowingPasswordAlert = true
            if let error = error {
                self.passwordError = error.description
            } else {
                self.passwordError = NexaError.unknownError.description
            }
        }
    }
}
