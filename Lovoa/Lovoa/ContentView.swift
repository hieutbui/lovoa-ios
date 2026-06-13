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
            HomeDashboard()
                .tabItem {
                    Label(Constants.dashboardString, systemImage: Constants.dashboardIcon)
                }
                .tag(0)
            
            // TAB 2: CO-DIARY TIMELINE
            Timeline()
                .tabItem {
                    Label(Constants.timelineString, systemImage: Constants.timelineIcon)
                }
                .tag(1)
            
            // TAB 3: USER PROFILE & SETTINGS
            Profile()
                .tabItem {
                    Label(Constants.profileString, systemImage: Constants.ProfileIcon)
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
