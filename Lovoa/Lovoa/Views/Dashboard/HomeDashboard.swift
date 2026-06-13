//
//  HomeDashboardView.swift
//  Lovoa
//
//  Created by Hieu Bui on 10/06/2026.
//

import SwiftUI
import SwiftData

struct HomeDashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var partnership: [Partnership]
    @Query private var auras: [AuraState]
    @Query private var milestones: [Milestone]
    
    @State private var isProUser: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                // 1. dynamic background canvas layer
                // fallback background color if no custom image path is mapped yet
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators:  false) {
                    VStack(spacing: 24) {
                        // 2. love counter zone
                        LoveCountersSection(partnership: partnership.first)
                        
                        // 3. partner avatars identity matrix
                        HStack(spacing: 40) {
                            AvatarIdentify(title: "You", aura: auras.first, isPro: true)
                            AvatarIdentify(title: "Partner", aura: auras.dropFirst().first, isPro: isProUser)
                        }
                        .padding(.vertical, 8)
                        
                        // 4. milestone countdowns grid
                        MilestonesSection(milestones: milestones)
                    }
                    .padding()
                }
            }
            .navigationTitle("Lovoa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: injectSampleData) {
                        Label("Edit", systemImage: "long.text.page.and.pencil")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: injectSampleData) {
                        Label("Scan QR", systemImage: "qrcode.viewfinder")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: injectSampleData) {
                        Label("Camera", systemImage: "camera.on.rectangle")
                    }
                }
            }
        }
    }
    
    // Temporary debug helper to seed local memory with test states
    private func injectSampleData() {
        let samplePartner = Partnership(
            startDate: Calendar.current.date(byAdding: .day, value: -365, to: Date()) ?? Date(),
            partner1Id: UUID(),
            partner2Id: UUID()
        )
        modelContext.insert(samplePartner)
        
        let selfAura = AuraState(userId: samplePartner.partner1Id, displayName: "Hieu Bui", birthDate: Date())
        let partnerAura = AuraState(userId: samplePartner.partner2Id, displayName: "Partner", focusLabel: "Coding Lovoa 💻", batteryLevel: 88)
        
        modelContext.insert(selfAura)
        modelContext.insert(partnerAura)
        
        modelContext.insert(Milestone(id: UUID(), title: "100 Days Together", targetDate: Date().addingTimeInterval(34 * 86400)))
        modelContext.insert(Milestone(id: UUID(), title: "Paris Trip ✈️", targetDate: Date().addingTimeInterval(40 * 86400), isCustom: true))
    }
}

#Preview {
    HomeDashboardView()
        .modelContainer(for: [AuraState.self, Partnership.self, Milestone.self], inMemory: true)
}
