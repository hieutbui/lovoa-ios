//
//  ContentView.swift
//  Lovoa
//
//  Created by Hieu Bui on 23/05/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // TAB 1: DASHBOARD STREAM
            HomeDashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }
                .tag(0)
            
            // TAB 2: CO-DIARY TIMELINE
            TimelineListView()
                .tabItem {
                    Label("Timeline", systemImage: "calendar.day.timeline.left")
                }
                .tag(1)
            
            // TAB 3: USER PROFILE & SETTINGS
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(2)
        }
        .tint(.accentColor)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Partnership.self, AuraState.self, Milestone.self], inMemory: true)
}
