//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Alexandre D'AMBRISI on 06/08/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> Void) {
        let entry = DayEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<DayEntry>) -> Void) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of seven entries an hour apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDate =  Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MonthlyWidgetEntryView : View {
    var entry: DayEntry

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.gray.gradient)
            
            VStack {
                HStack {
                    Text("🏂")
                        .font(.title)
                    
                    Text(entry.date.weekdayDisplayFormat)
                        .font(.title3)
                        .bold()
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(.black.opacity(0.6))
                    
                    Spacer()
                }
                
                Text(entry.date.dayDisplayFormat)
                    .font(.system(size: 80, weight: .heavy))
                    .foregroundStyle(.white.opacity(0.8))
            }
            .padding()
        }
    }
}

struct MonthlyWidget: Widget {
    let kind: String = "MonthlyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MonthlyWidgetEntryView(entry: entry)
                .containerBackground(.black, for: .widget)
        }
        .configurationDisplayName("Monthly Widget")
        .description("The theme of the widget changes based on month.")
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
        
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    DayEntry(date: .now)
}
