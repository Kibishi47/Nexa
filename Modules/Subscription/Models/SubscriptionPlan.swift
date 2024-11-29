//
//  SubscriptionPlan.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//


import SwiftUI

struct SubscriptionPlan: Identifiable {
    let id = UUID()
    let name: String
    let shortName: String
    let price: String
    let features: [String]
    let color: Color
}
