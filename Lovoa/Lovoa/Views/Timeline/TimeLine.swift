//
//  TimeLineListView.swift
//  Lovoa
//
//  Created by Hieu Bui on 10/06/2026.
//

import SwiftUI
import SwiftData

struct Timeline: View {
    @Query private var entries: [TimelineEntry]
    
    var body: some View {
        NavigationStack {
            VStack {
                if entries.isEmpty {
                    ContentUnavailableView(
                        "No Shared Moments Yet",
                        systemImage: "photo.on.rectangle.angled",
                        description: Text("Tap the Camera button on your Home Dashboard to share your first memory micro-note!")
                    )
                } else {
                    List(entries) { entry in
                        Text(entry.textSpace)
                    }
                }
            }
            .navigationTitle("Co-Diary Timeline")
        }
    }
}

#Preview {
    Timeline()
        .modelContainer(for: [TimelineEntry.self], inMemory: true)
}
