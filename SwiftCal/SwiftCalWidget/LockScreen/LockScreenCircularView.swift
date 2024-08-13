//
//  LockScreenCircularView.swift
//  SwiftCalWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 13/08/2024.
//

import SwiftUI
import WidgetKit

struct LockScreenCircularView: View {
    var entry: CalendarEntry
    
    private var currentCalendarDays: Int {
        entry.days.filter { $0.date?.monthInt == Date().monthInt }.count
    }
    private var daysStudies: Int {
        entry.days.filter { $0.date?.monthInt == Date().monthInt }.filter { $0.didStudy }.count
    }
    
    var body: some View {
        Gauge(value: Double(daysStudies), in: 1...Double(currentCalendarDays)) {
            Image(systemName: "swift")
        } currentValueLabel: {
            Text("\(daysStudies)")
        }
        .gaugeStyle(.accessoryCircular)
    }
}

#Preview(as: .accessoryCircular) {
    SwiftCalWidget()
} timeline: {
    CalendarEntry(date: .now, days: [])
}
