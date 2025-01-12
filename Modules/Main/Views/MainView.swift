//
//  MainView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @State private var isMenuShowing = false
    @State private var currentSubscription: SubscriptionPlan = SubscriptionRepository().getCurrentPlan()
    @StateObject private var viewModel = MainViewModel()
    
    let features: [AIFeature] = FeatureRepository().getHistoryItems()
    let recentHistory: [HistoryItem] = Array(HistoryRepository().getHistoryItems().prefix(3))
    
    var body: some View {
        ZStack {
            // Main content
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button(action: {
                        withAnimation(.easeOut) {
                            isMenuShowing.toggle()
                        }
                    }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Nexa")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        navigationManager.navigateToSubscription()
                    }, label: {
                        SubscriptionBadge(plan: currentSubscription)
                    })
                }
                .padding()
                .background(Color.black)
                
                // Scrollable content
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // Title
                        HStack {
                            Text("Fonctionnalités")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        // Features grid
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(features.indices, id: \.self) { index in
                                Button(action: {
//                                    navigationManager.navigateToConversationList(feature: .chat)
                                    navigationManager.navigateToConversationList(feature: features[index])
                                }, label: {
                                    FeatureCard(feature: features[index])
                                })
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        
                        // Historical section
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Historique récent")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button("Voir tout") {
                                    navigationManager.navigateToHistory()
                                }
                                .foregroundColor(.blue)
                            }
                            
                            if (viewModel.isLoading) {
                                Spacer()
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                Spacer()
                            } else {
                                ForEach(viewModel.conversations) { conversation in
                                    Button(action: {
                                        navigationManager.navigateToConversation(conversation: conversation, feature: conversation.feature)
                                    }, label: {
                                        ConversationRowView(conversation: conversation)
                                    })
                                }
                            }
                        }
                        .padding()
                    }
                }
                .padding(.top, 10)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            
            // Sidebar
            SideMenu(isShowing: $isMenuShowing)
                .environmentObject(navigationManager)
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(NavigationManager())
}
