//
//  MainHeaders.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct NavigateBackHeader<RightElement: View>: View {
    let title: String
    let rightElement: RightElement
    
    init(title: String, rightElement: RightElement = EmptyView()) {
        self.title = title
        self.rightElement = rightElement
    }
    
    var body: some View {
        ZStack {
            BackButton()
            
            HStack {
                Spacer()
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                rightElement
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        VStack {
            NavigateBackHeader(title: "Title")
            Spacer()
        }
    }
}
