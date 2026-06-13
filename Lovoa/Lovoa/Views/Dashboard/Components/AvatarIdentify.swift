//
//  AvatarIdentify.swift
//  Lovoa
//
//  Created by Hieu Bui on 11/06/2026.
//

import Foundation
import SwiftUI

struct AvatarIdentify: View {
    var title: String
    var aura: AuraState?
    var isPro: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                // profile avatar placeholder ring
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 80, height: 80)
                    .overlay(Text(aura?.displayName.prefix(1).uppercased() ?? "❤️")
                        .font(.title)
                    )
                
                // battery overlay for pro users
                if isPro, let battery = aura?.batteryLevel {
                    Text("\(battery)%")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .padding(4)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .clipShape(Capsule())
                        .offset(x: 4, y: 4)
                        
                }
            }
            
            Text(aura?.displayName ?? title)
                .font(.headline)
            
            // zodiac placeholder text
            Text("Scorpio ♏️")
                .font(.caption2)
                .opacity(0.5)
            
            // focus label for pro
            if isPro, let focus = aura?.focusLabel {
                Text(focus)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
            }
        }
    }
}
