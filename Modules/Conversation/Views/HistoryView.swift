//
//  HistoryView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            NavigateBackHeader(title: "Historique")
                .padding()
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Rechercher...", text: $viewModel.searchText)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // History list
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.filteredConversation) { conversation in
                        ConversationRowView(conversation: conversation)
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
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    HistoryView()
        .environmentObject(NavigationManager())
}
