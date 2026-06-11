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
                            AvatarIdentifyView(title: "You", aura: auras.first, isPro: true)
                            AvatarIdentifyView(title: "Partner", aura: auras.dropFirst().first, isPro: isProUser)
                        }
                        .padding(.vertical, 8)
                        
                        // 4. milestone countdowns grid
                        MilestonesSection(milestones: milestones)
                        
                        // 5. quick scontrols core interface
                        QuickActionControlsPanel()
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


// 2. love counter stack view
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

// 3. avatar telementry rendering frame
struct AvatarIdentifyView: View {
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

// 4. milestone matrix rows card
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

// 5. Controls Drawer Interface Block
struct QuickActionControlsPanel: View {
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {}) {
                Image(systemName: "pencil")
                    .frame(maxWidth: .infinity)
            }
            Button(action: {}) {
                Image(systemName: "qrcode")
                    .frame(maxWidth: .infinity)
            }
            Button(action: {}) {
                Image(systemName: "camera.fill")
                    .frame(maxWidth: .infinity)
            }
        }
        .font(.title3)
        .padding()
        .buttonStyle(.borderedProminent)
        .tint(.accentColor)
    }
}

// utility hex engine extension
extension Color {
    init (hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 1)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

#Preview {
    HomeDashboardView()
        .modelContainer(for: [AuraState.self, Partnership.self, Milestone.self], inMemory: true)
}
