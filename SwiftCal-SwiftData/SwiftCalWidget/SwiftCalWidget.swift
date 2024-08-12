//
//  SwiftCalWidget.swift
//  SwiftCalWidget
//
//  Created by Alexandre D'AMBRISI on 12/08/2024.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CalendarEntry {
        CalendarEntry(date: Date(), days: [])
    }

    @MainActor func getSnapshot(in context: Context, completion: @escaping (CalendarEntry) -> ()) {
        let entry = CalendarEntry(date: Date(), days: fetDays())
        completion(entry)
    }

    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = CalendarEntry(date: Date(), days: fetDays())
        let timeline = Timeline(entries: [entry], policy: .after(.now.endOfDay))
        completion(timeline)
    }
    
    @MainActor func fetDays() -> [Day] {
        var sharedStoreURL: URL {
            let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.dambrisi-corp.SwiftCal")!
            return container.appendingPathComponent("SwiftCal.sqlite")
        }
        
        let container: ModelContainer = {
            let config = ModelConfiguration(url: sharedStoreURL)
            return try! ModelContainer(for: Day.self, configurations: config)
        }()
        
        let startDate = Date().startOfCalendarWithPrefixDays
        let endDate = Date().endOfMonth
        let predicate = #Predicate<Day> { $0.date > startDate && $0.date < endDate }
        let descriptor = FetchDescriptor<Day>(predicate: predicate, sortBy: [.init(\.date)])
        
        return try! container.mainContext.fetch(descriptor)
    }
}

struct CalendarEntry: TimelineEntry {
    let date: Date
    let days: [Day]
}

struct SwiftCalWidget: Widget {
    let kind: String = "SwiftCalWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                SwiftCalWidgetView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SwiftCalWidgetView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Swift Study Calendrar")
        .description("Track days you study Swift with streaks.")
        .supportedFamilies([.systemMedium])
    }
}
