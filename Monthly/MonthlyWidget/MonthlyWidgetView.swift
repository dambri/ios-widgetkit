//
//  MonthlyWidgetView.swift
//  MonthlyWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 06/08/2024.
//

import SwiftUI
import WidgetKit

struct MonthlyWidgetView: View {
    @Environment(\.showsWidgetContainerBackground) var showBackground
    var entry: DayEntry
    private var config: MonthConfig

    init(entry: DayEntry) {
        self.entry = entry
        self.config = MonthConfig.determineConfig(from: entry.date)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(config.emojiText)
                        .font(.title)
                    
                    Text(entry.date.weekdayDisplayFormat)
                        .font(.title3)
                        .bold()
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(showBackground ? config.weekdayTextColor : .white)
                    
                    Spacer()
                }
                .id(entry.date)
                .transition(.push(from: .trailing))
                .animation(.bouncy, value: entry.date)
                
                Text(entry.date.dayDisplayFormat)
                    .font(.system(size: 80, weight: .heavy))
                    .foregroundStyle(showBackground ? config.dayTextColor : .white)
                    .contentTransition(.numericText())
            }
            .containerBackground(for: .widget) {
                ContainerRelativeShape()
                    .fill(config.backgroundColor.gradient)
            }
        }
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    DayEntry(date: .now)
    MockData.dataOne
    MockData.dataTwo
    MockData.dataThree
    MockData.dataFour
}
