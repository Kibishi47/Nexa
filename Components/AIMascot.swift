//
//  AIMascot.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 28/11/2024.
//

import SwiftUI

struct AIMascot: View {
    let animationsEnabled: Bool
    
    @State private var hoverOffset: CGFloat = 0
    @State private var glowOpacity = 0.0
    @State private var eyeScale: CGFloat = 1.0
    @State private var ringRotation: Double = 0
    
    init(animationsEnabled: Bool = true) {
        self.animationsEnabled = animationsEnabled
    }
    
    var body: some View {
        ZStack {
            // Glow effect under the robot
            Ellipse()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.clear]),
                        center: .center,
                        startRadius: 5,
                        endRadius: 50
                    )
                )
                .frame(width: 100, height: 20)
                .blur(radius: 10)
                .offset(y: 80)
                .opacity(glowOpacity)
            
            // Robot main body
            ZStack {
                // Rotating rings
                ForEach(0..<2) { i in
                    Circle()
                        .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                        .frame(width: 160 + CGFloat(i * 30), height: 160 + CGFloat(i * 30))
                        .rotationEffect(.degrees(ringRotation + Double(i * 45)))
                }
                
                // Body
                VStack(spacing: 0) {
                    // Head
                    ZStack {
                        // Main head shape
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.black)
                            .frame(width: 120, height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        
                        // Eyes
                        HStack(spacing: 25) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 15, height: 15)
                                .scaleEffect(eyeScale)
                                .overlay(
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 5, height: 5)
                                        .offset(x: 2, y: -2)
                                )
                            
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 15, height: 15)
                                .scaleEffect(eyeScale)
                                .overlay(
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 5, height: 5)
                                        .offset(x: 2, y: -2)
                                )
                        }
                        
                        // Technological details
                        ForEach(0..<3) { i in
                            Rectangle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 30, height: 1)
                                .offset(x: -40, y: CGFloat(i * 10) - 10)
                        }
                    }
                    
                    // Lower body
                    ZStack {
                        // Main body shape
                        Capsule()
                            .fill(Color.black)
                            .frame(width: 80, height: 60)
                            .overlay(
                                Capsule()
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        
                        // Luminous details
                        VStack(spacing: 8) {
                            ForEach(0..<3) { _ in
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 4, height: 4)
                                    .opacity(glowOpacity)
                            }
                        }
                    }
                    .offset(y: -20)
                }
            }
            .offset(y: hoverOffset)
        }
        .onAppear {
            if animationsEnabled {
                // Levitation animation
                withAnimation(
                    .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true)
                ) {
                    hoverOffset = -10
                    glowOpacity = 0.8
                }
                
                // Ring rotation animation
                withAnimation(
                    .linear(duration: 20)
                    .repeatForever(autoreverses: false)
                ) {
                    ringRotation = 360
                }
                
                // Eye animation
                Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        eyeScale = 0.1
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            eyeScale = 1.0
                        }
                    }
                }
            } else {
                // Set default values when animations are disabled
                hoverOffset = -5
                glowOpacity = 0.4
                ringRotation = 0
                eyeScale = 1.0
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        VStack(spacing: 50) {
            AIMascot()
                //.scaleEffect(2)
            
            AIMascot(animationsEnabled: false)
                //.scaleEffect(2)
        }
    }
}

