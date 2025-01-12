//
//  LanguageManager.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 12/01/2025.
//

import Foundation

class LanguageManager: ObservableObject {
    private static var instance: LanguageManager? = nil
    
    @Published var availableLanguages: [Language] = []
    @Published var selectedLanguage: Language
    @Published var isLoading = false
    @Published var hasError = false
    @Published var errorMessage = ""
    
    private init() {
        let currentLocale = Locale.current
        let languageCode = currentLocale.language.languageCode?.identifier ?? "en"
        let regionCode = currentLocale.language.region?.identifier
        
        self.selectedLanguage = Language(
            code: languageCode,
            region: regionCode,
            name: currentLocale.localizedString(forLanguageCode: languageCode)?.capitalized ?? "English")
        
        self.setupAvailableLanguages()
    }
    
    static func getInstance() -> LanguageManager {
        if instance == nil {
            instance = LanguageManager()
        }
        return instance!
    }
    
    private func setupAvailableLanguages() {
        // Récupérer les langues depuis les Localizations du projet
        var languages: [Language] = []
        
        // Obtenir les langues depuis le Bundle principal
        let localizations = Bundle.main.localizations.filter({ $0 != "Base" })
        for localization in localizations {
            let locale = Locale(identifier: localization)
            let languageCode = locale.language.languageCode?.identifier ?? localization
            let regionCode = locale.language.region?.identifier
            
            if let name = locale.localizedString(forLanguageCode: languageCode) {
                let language = Language(
                    code: languageCode,
                    region: regionCode,
                    name: name.capitalized
                )
                languages.append(language)
            }
        }
        
        // Trier les langues par nom
        availableLanguages = languages.sorted { $0.name < $1.name }
        
        // Mettre à jour la langue sélectionnée si elle existe dans les langues disponibles
        if let currentLanguage = availableLanguages.first(where: { $0.code == selectedLanguage.code }) {
            selectedLanguage = currentLanguage
        }
    }
    
    @MainActor
    func updateLanguage() async {
        isLoading = true
        
        do {
            // Simuler un délai réseau
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            // Mettre à jour la langue du système
            UserDefaults.standard.set([selectedLanguage.code], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            
            // Notifier du changement de langue
            NotificationCenter.default.post(
                name: NSNotification.Name("LanguageChanged"),
                object: nil
            )
            
        } catch {
            hasError = true
            errorMessage = "Impossible de mettre à jour la langue"
        }
        
        isLoading = false
    }
}
