//
//  MonthlyWidgetView.swift
//  MonthlyWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 06/08/2024.
//

import SwiftUI
import WidgetKit

struct MonthlyWidgetView: View {
    var entry: DayEntry
    private var config: MonthConfig

    init(entry: DayEntry) {
        self.entry = entry
        self.config = MonthConfig.determineConfig(from: entry.date)
    }
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(config.backgroundColor.gradient)
            
            VStack {
                HStack {
                    Text(config.emojiText)
                        .font(.title)
                    
                    Text(entry.date.weekdayDisplayFormat)
                        .font(.title3)
                        .bold()
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(config.weekdayTextColor)
                    
                    Spacer()
                }
                
                Text(entry.date.dayDisplayFormat)
                    .font(.system(size: 80, weight: .heavy))
                    .foregroundStyle(config.dayTextColor)
            }
            .padding()
        }
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    DayEntry(date: .now)
    DayEntry(date: dateToDisplay(month: 10, day: 22))
}

// Only here to test quickly different month and day
func dateToDisplay(month: Int, day: Int) -> Date {
    let components = DateComponents(calendar: Calendar.current, year: 2024, month: month, day: day)
    return Calendar.current.date(from: components)!
}
