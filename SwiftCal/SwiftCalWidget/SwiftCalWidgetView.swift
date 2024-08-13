//
//  SwiftCalWidgetView.swift
//  SwiftCalWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 12/08/2024.
//

import SwiftUI
import WidgetKit

struct SwiftCalWidgetView: View {
    @Environment(\.widgetFamily) var family
    var entry: CalendarEntry
    
    var body: some View {
        switch family {
        case .systemSmall, .systemLarge, .systemExtraLarge:
            EmptyView()
        case .systemMedium:
            MediumCalendarView(entry: entry, streakValue: calculateStreakValue())
        case .accessoryCorner:
            EmptyView()
        case .accessoryCircular:
            LockScreenCircularView(entry: entry)
        case .accessoryRectangular:
            LockScreenRectangularView(entry: entry)
        case .accessoryInline:
            Label("Streak - \(calculateStreakValue()) days", systemImage: "swift")
                .widgetURL(URL(string: "streak"))
        @unknown default:
            EmptyView()
        }
    }
    
    private func calculateStreakValue() -> Int {
        guard !entry.days.isEmpty else { return 0 }

        let nonFutureDays = entry.days.filter { $0.date!.dayInt <= Date().dayInt }

        var streakCount = 0

        for day in nonFutureDays.reversed() {
            if day.didStudy {
                streakCount += 1
            } else {
                if day.date!.dayInt != Date().dayInt {
                    break
                }
            }
        }

        return streakCount
    }
}

#Preview(as: .accessoryInline) {
    SwiftCalWidget()
} timeline: {
    CalendarEntry(date: .now, days: [])
}
