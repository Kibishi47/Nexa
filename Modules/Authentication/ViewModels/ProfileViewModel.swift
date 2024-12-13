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
    @Published var isLogoutLoading = false
    
    // Showing variables
    @Published var isShowingChangePassowrd = false
    @Published var isShowingImagePicker = false
    
    // Error variables
    @Published var errorMessage: String = "" {
        didSet {
            hasError = !errorMessage.isEmpty
        }
    }
    @Published var hasError: Bool = false
    
    // Services
    private let authService = AuthService.instance
    private let profileService = ProfileService.instance
    
    func fetchData() async {
        if let user = await authService.getUser() {
            setUser(user)
            if let profile = await profileService.getProfileByUserId(user.id){
                setProfile(profile)
            } else {
                setErrorMessage("Profil non chargé")
            }
        } else {
            setErrorMessage("Utilisateur non chargé")
        }
        setIsLoading(false)
    }
    
    func updateUsername() async {
        setIsUpdating(true)
        setIsUpdating(false)
    }
    
    func updateEmail() async {
        setIsUpdating(true)
        setIsUpdating(false)
    }
    
    func changePassword() {
        
    }
    
    func logout() async {
        self.setIsLogoutLoading(true)
        await authService.logout() { success, error in
            self.setIsLogoutLoading(false)
            if (!success) {
                // TODO: Inform user
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
    
    private func setIsLogoutLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLogoutLoading = isLoading
        }
    }
    
    private func setErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
        }
    }
    
    private func setUser(_ user: Supabase.User?) {
        DispatchQueue.main.async {
            self.user = user
        }
    }
    
    private func setProfile(_ profile: Profile?) {
        DispatchQueue.main.async {
            self.profile = profile
        }
    }
}
