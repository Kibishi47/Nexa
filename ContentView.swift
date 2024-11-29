//
//  ContentView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some View {
        navigationManager.currentView
            .environmentObject(navigationManager)
    }
}

#Preview {
    ContentView()
}
