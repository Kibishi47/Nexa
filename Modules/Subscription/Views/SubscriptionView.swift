//
//  SubscriptionView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct SubscriptionView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let plans: [SubscriptionPlan] = SubscriptionRepository().getPlans()
    
    var body: some View {
        ScrollView {
            VStack {
                // Header
                NavigateBackHeader(title: "Abonnement")
                    .padding(.horizontal)
                    .padding(.bottom)
                
                
                // Main content
                Text("Choisissez votre plan")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                
                VStack(spacing: 25) {
                    ForEach(plans) { plan in
                        SubscriptionCard(plan: plan)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarHidden(true)
    }
}

#Preview {
    SubscriptionView()
        .environmentObject(NavigationManager())
}
