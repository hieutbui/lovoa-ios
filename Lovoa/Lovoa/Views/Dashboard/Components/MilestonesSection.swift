//
//  MilestonesSection.swift
//  Lovoa
//
//  Created by Hieu Bui on 11/06/2026.
//

import Foundation
import SwiftUI

struct MilestonesSection: View {
    var milestones: [Milestone]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upcoming Milestones")
                .font(.subheadline)
                .fontWeight(.bold)
                .opacity(0.7)
            
            if milestones.isEmpty {
                Text("Tap Seed Data to simulate upcoming milestones.")
                    .font(.caption)
                    .opacity(0.4)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                ForEach(milestones) { milestone in
                    HStack {
                        Text(milestone.title)
                            .font(.body)
                        Spacer()
                        Text("Target Days")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(14)
                }
            }
        }
    }
}
