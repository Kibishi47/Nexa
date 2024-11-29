//
//  SubscriptionBadge.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct SubscriptionBadge: View {
    let plan: SubscriptionPlan
    
    var body: some View {
        Text(plan.shortName)
            .font(.system(size: 12, weight: .semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(plan.color.opacity(0.2))
            .foregroundColor(plan.color)
            .cornerRadius(12)
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        SubscriptionBadge(
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
