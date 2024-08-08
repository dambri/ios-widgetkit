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
    private let funFontName = "Chalkduster"

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
                    
                    Spacer()
                    
                    Text(entry.date.monthDisplayFormat)
                        .font(entry.showFunFont ? .custom(funFontName, size: 12) : .system(size: 12, weight: .heavy))
                        .bold()
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(showBackground ? config.monthTextColor : .white)
                        .shadow(color: config.shadowColor, radius: 0.2)
                        .scaledToFit()
                }
                .id(entry.date)
                .transition(.push(from: .bottom))
                .animation(.bouncy, value: entry.date)
                
                VStack(alignment: .center) {
                    Text(entry.date.weekdayDisplayFormat)
                        .font(entry.showFunFont ? .custom(funFontName, size: 24) : .body)
                        .bold()
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(showBackground ? config.dayTextColor : .white)
                        .shadow(color: config.shadowColor, radius: 0.2)
                    
                    Text(entry.date.dayDisplayFormat)
                        .font(entry.showFunFont ? .custom(funFontName, size: 60) : .system(size: 60, weight: .heavy))
                        .foregroundStyle(showBackground ? config.dayTextColor : .white)
                        .shadow(color: config.shadowColor, radius: 0.5, y: 1)
                        .contentTransition(.numericText())
                }
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
    DayEntry(date: .now, showFunFont: false)
    MockData.dataOne
    MockData.dataTwo
    MockData.dataThree
    MockData.dataFour
    MockData.dataFive
}
