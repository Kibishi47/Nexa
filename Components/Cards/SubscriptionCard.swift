//
//  SubscriptionCard.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct SubscriptionCard: View {
    let plan: SubscriptionPlan
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(plan.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(plan.color)
            
            Text(plan.price)
                .font(.title3)
                .foregroundColor(.white)
            
            ForEach(plan.features, id: \.self) { feature in
                HStack(spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(plan.color)
                    Text(feature)
                        .foregroundColor(.white)
                }
            }
            
            PrimaryButton(title: "Choisir ce plan") {
                // Action to select plan
            }
            .padding(.top, 10)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.05))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(plan.color, lineWidth: 2)
        )
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        SubscriptionCard(
            plan: SubscriptionPlan(
                name: "Basic",
                shortName: "Basic",
                price: "9,99€/mois",
                features: ["Accès limité au chat IA", "Génération d'images (10/mois)", "Support par email"],
                color: .blue
            )
        )
    }
}
