//
//  MainHeaders.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct NavigateBackHeader<RightElement: View>: View {
    let rightElement: RightElement
    var title: Text
    
    init(title: String, rightElement: RightElement = EmptyView()) {
        self.title = Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
        self.rightElement = rightElement
    }
    
    var body: some View {
        if rightElement is EmptyView {
            ZStack {
                HStack {
                    BackButton()
                    Spacer()
                }
                HStack {
                    Spacer()
                    title
                    Spacer()
                }
            }
        } else {
            HStack {
                BackButton()
                Spacer()
                title
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
            NavigateBackHeader(
                title: "Title",
                rightElement: Button(action: {}, label: {
                    Image(systemName: "person")
                })
            )
            NavigateBackHeader(
                title: "Title"
            )
            Spacer()
        }
    }
}
