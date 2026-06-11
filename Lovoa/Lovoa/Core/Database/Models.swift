//
//  Models.swift
//  Lovoa
//
//  Created by Hieu Bui on 10/06/2026.
//

import Foundation
import SwiftData

// Partnership Context
@Model
final class Partnership {
    @Attribute(.unique) var id: UUID
    var startDate: Date
    
    // absolute db identification
    var partner1Id: UUID
    var partner2Id: UUID
    
    // background UI
    var dashboardBackgroundPath: String?
    
    // =================================================================
    // 🎨 GRANULAR MULTI-COMPONENT COLOR SYSTEM
    // =================================================================
    
    // type 1: total days counter component color
    var colorTotalDaysHex: String
    
    // type 2: year/month/week/day breakdown component colors
    var colorYearHex: String
    var colorMonthHex: String
    var colorWeekHex: String
    var colorDayHex: String
    
    // type 3: hour/minute/second precise ticker component colors
    var colorHourHex: String
    var colorMinuteHex: String
    var colorSecondHex: String
    
    // =================================================================
    // INITIALIZER
    // =================================================================
    init(id: UUID = UUID(), startDate: Date, partner1Id: UUID, partner2Id: UUID, dashboardBackgroundPath: String? = nil, colorTotalDaysHex: String = "#FF2D55", colorYearHex: String = "#FF9500", colorMonthHex: String = "#FFCC00", colorWeekHex: String = "#34C759", colorDayHex: String = "#007AFF", colorHourHex: String = "#5856D6", colorMinuteHex: String = "#AF52DE", colorSecondHex: String = "FF3B30") {
        self.id = id
        self.startDate = startDate
        self.partner1Id = partner1Id
        self.partner2Id = partner2Id
        self.dashboardBackgroundPath = dashboardBackgroundPath
        
        self.colorTotalDaysHex = colorTotalDaysHex
        self.colorYearHex = colorYearHex
        self.colorMonthHex = colorMonthHex
        self.colorWeekHex = colorWeekHex
        self.colorDayHex = colorDayHex
        self.colorHourHex = colorHourHex
        self.colorMinuteHex = colorMinuteHex
        self.colorSecondHex = colorSecondHex
    }
    
    // =================================================================
    // UI CLIENT HELPER LOGIC
    // =================================================================
    
    // Dynamically resolves the partner's ID based on whoever is viewing the local dashboard
    func getPartnerId(for currentUserId: UUID) -> UUID {
        return currentUserId == partner1Id ? partner2Id : partner1Id
    }
}

@Model
final class AuraState {
    @Attribute(.unique) var userId: UUID
    var displayName: String
    var avatarAssetPath: String?
    var birthDate: Date?
    var updatedAt: Date
    var moodSpectrumRaw: String
    var focusLabel: String?
    var batteryLevel: Int?
    
    init(userId: UUID, displayName: String, avatarAssetPath: String? = nil, birthDate: Date? = nil, updatedAt: Date = Date(), moodSpectrumRaw: String = "CYAN_CALM", focusLabel: String? = nil, batteryLevel: Int? = nil) {
        self.userId = userId
        self.displayName = displayName
        self.avatarAssetPath = avatarAssetPath
        self.birthDate = birthDate
        self.updatedAt = updatedAt
        self.moodSpectrumRaw = moodSpectrumRaw
        self.focusLabel = focusLabel
        self.batteryLevel = batteryLevel
    }
}

@Model
final class Milestone {
    @Attribute(.unique) var id: UUID
    var title: String
    var targetDate: Date
    var isCustom: Bool
    
    init(id: UUID, title: String, targetDate: Date, isCustom: Bool = false) {
        self.id = id
        self.title = title
        self.targetDate = targetDate
        self.isCustom = isCustom
    }
}

@Model
final class TimelineEntry {
    @Attribute(.unique) var entryId: UUID
    var creatorId: UUID
    var createdAt: Date
    var contentTypeRaw: String
    var textSpace: String
    var mediaUrlString: String?
    var blurhash: String?
    
    init(entryId: UUID = UUID(), creatorId: UUID, createdAt: Date = Date(), contentTypeRaw: String = "TEXT", textSpace: String, mediaUrlString: String? = nil, blurhash: String? = nil) {
        self.entryId = entryId
        self.creatorId = creatorId
        self.createdAt = createdAt
        self.contentTypeRaw = contentTypeRaw
        self.textSpace = textSpace
        self.mediaUrlString = mediaUrlString
        self.blurhash = blurhash
    }
}
