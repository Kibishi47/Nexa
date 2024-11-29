//
//  HistoryView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @State private var searchText = ""
    
    let historyItems: [HistoryItem] = HistoryRepository().getHistoryItems()
    
    var filteredItems: [HistoryItem] {
        if searchText.isEmpty {
            return historyItems
        } else {
            return historyItems.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            NavigateBackHeader(title: "Historique")
                .padding()
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Rechercher...", text: $searchText)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // History list
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(filteredItems) { item in
                        HistoryRow(item: item)
                    }
                }
                .padding()
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarHidden(true)
    }
}

#Preview {
    HistoryView()
        .environmentObject(NavigationManager())
}
