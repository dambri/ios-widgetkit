//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Alexandre D'AMBRISI on 06/08/2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), showFunFont: false)
    }
    
    func snapshot(for configuration: ChangeFontIntent, in context: Context) async -> DayEntry {
        return DayEntry(date: Date(), showFunFont: false)
    }
    
    func timeline(for configuration: ChangeFontIntent, in context: Context) async -> Timeline<DayEntry> {
        var entries: [DayEntry] = []

        let showFunFont = configuration.funFont
        
        // Generate a timeline consisting of seven entries an hour apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate =  Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate, showFunFont: showFunFont)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct MonthlyWidget: Widget {
    let kind: String = "MonthlyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ChangeFontIntent.self, provider: Provider()) { entry in
            MonthlyWidgetView(entry: entry)
        }
        .configurationDisplayName("Monthly Widget")
        .description("The theme of the widget changes based on month.")
        .supportedFamilies([.systemSmall])
        .disfavoredLocations([.lockScreen], for: [.systemSmall])
    }
}


