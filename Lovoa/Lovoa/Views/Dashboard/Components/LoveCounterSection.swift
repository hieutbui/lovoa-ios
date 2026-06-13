//
//  LoveCounterSection.swift
//  Lovoa
//
//  Created by Hieu Bui on 11/06/2026.
//

import Foundation
import SwiftUI

struct LoveCountersSection: View {
    var partnership: Partnership?
    
    var body: some View {
        VStack(spacing: 12) {
            VStack {
                Text("365")
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                Text("DAYS TOGETHER")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .tracking(2)
                    .opacity(0.6)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(24)
        }
    }
}
