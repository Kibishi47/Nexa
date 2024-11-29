//
//  SubscriptionRepository.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import Foundation


struct SubscriptionRepository {
    private let plans: [SubscriptionPlan] = [
        SubscriptionPlan(
            name: "Basic",
            shortName: "Basic",
            price: "9,99€/mois",
            features: ["Accès limité au chat IA", "Génération d'images (10/mois)", "Support par email"],
            color: .blue
        ),
        SubscriptionPlan(
            name: "Pro",
            shortName: "Pro",
            price: "19,99€/mois",
            features: ["Chat IA illimité", "Génération d'images illimitée", "Transcription audio", "Support prioritaire"],
            color: .purple
        ),
        SubscriptionPlan(
            name: "Enterprise",
            shortName: "Ent",
            price: "Sur devis",
            features: ["Toutes les fonctionnalités Pro", "API personnalisée", "Intégration sur mesure", "Support dédié"],
            color: .orange
        )
    ]
    
    func getPlans() -> [SubscriptionPlan] {
        plans
    }
    
    func getCurrentPlan() -> SubscriptionPlan {
        plans[0]
    }
}
