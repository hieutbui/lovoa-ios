//
//  ProfileView.swift
//  Lovoa
//
//  Created by Hieu Bui on 10/06/2026.
//

import SwiftUI
import SwiftData

struct Profile: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var auras: [AuraState]
    @Query private var partnerships: [Partnership]
    
    @State private var isBiometricLockEnabled: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                // 1. USER INTENSITY CARD
                Section {
                    HStack(spacing: 16) {
                        Circle()
                            .fill(Color.accentColor.opacity(0.1))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Text(auras.first?.displayName.prefix(1).uppercased() ?? "👤")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(auras.first?.displayName ?? "Your Profile")
                                .font(.headline)
                            
                            Text("Connected to Partner")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                // 2. PREMIUM UPGRADE BANNER
                Section {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("👑 Upgrade to Lovoa Pro")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("Unlock Permanent HD Cloud Storage, Advanced Analytics, and Custom Fluid Widgets.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                
                // 3. SECURITY & ESSENTIALS (FREE vs PRO GATING)
                Section("Security & Customization") {
                    Toggle(isOn: $isBiometricLockEnabled) {
                        Label("Biometric FaceID Lock", systemImage: "faceid")
                    }
                    
                    NavigationLink(destination: Text("Premium Accent Themes")) {
                        Label("App Icon & Aesthetics", systemImage: "app.badge")
                    }
                }
                
                // 4. THE DOWNGRADED PRIVACY TRACKER LINK
                Section("Utilities") {
                    NavigationLink(destination: OfflineCycleLogPlaceholder()) {
                        Label("Menstrual Cycle Log", systemImage: "calendar.badge.clock")
                            .foregroundColor(.pink)
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

// Compact, private fallback viewer for the cycle tracking system
struct OfflineCycleLogPlaceholder: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.text.square.fill")
                .font(.system(size: 60))
                .foregroundColor(.pink)
            Text("Local Privacy Log")
                .font(.title3)
                .fontWeight(.bold)
            Text("Your personal calendar metrics stay directly inside your client-side sandbox container for maximum security.")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .navigationTitle("Cycle Log")
    }
}

#Preview {
    Profile()
        .modelContainer(for: [AuraState.self, Partnership.self], inMemory: true)
}
