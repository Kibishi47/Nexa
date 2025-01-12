//
//  BackButton.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct BackButton: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    var body: some View {
        HStack {
            Button(action: { navigationManager.navigateBack() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
        .padding(.top, 5)
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        VStack {
            BackButton()
            Spacer()
        }
    }
}
