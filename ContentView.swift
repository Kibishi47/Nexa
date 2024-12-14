//
//  ContentView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationManager = NavigationManager()
    @StateObject private var alertManager = AlertManager()
    
    var body: some View {
        navigationManager.currentView
            .environmentObject(navigationManager)
            .environmentObject(alertManager)
            .alert(isPresented: $alertManager.presented) {
                Alert(
                    title: Text(alertManager.title),
                    message: Text(alertManager.message),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
}

#Preview {
    ContentView()
}
