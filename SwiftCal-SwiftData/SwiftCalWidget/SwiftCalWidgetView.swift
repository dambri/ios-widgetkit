//
//  SwiftCalWidgetView.swift
//  SwiftCalWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 12/08/2024.
//

import SwiftUI
import WidgetKit

struct SwiftCalWidgetView: View {
    var entry: Provider.Entry
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        HStack {
            Link(destination: URL(string: "streak")!) {
                VStack {
                    Text("\(calculateStreakValue())")
                        .font(.system(size: 70, design: .rounded))
                        .bold()
                        .foregroundStyle(.orange)
                    
                    Text("day streak")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Link(destination: URL(string: "calendar")!) {
                VStack {
                    CalendarHeaderView(font: .caption)
                    
                    LazyVGrid(columns: columns, spacing: 7) {
                        ForEach(entry.days) { day in
                            if day.date!.monthInt != Date().monthInt {
                                Text("")
                            } else {
                                Text("\(day.date!.formatted(.dateTime.day()))")
                                    .font(.caption2)
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(day.didStudy ? .orange : .secondary)
                                    .background(
                                        Circle()
                                            .foregroundStyle(.orange.opacity(day.didStudy ? 0.3 : 0.0))
                                            .scaleEffect(1.5)
                                    )
                            }
                        }
                    }
                }
                .padding(.leading, 6)
            }
            
        }
        .padding()
    }
    
    func calculateStreakValue() -> Int {
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

#Preview(as: .systemMedium) {
    SwiftCalWidget()
} timeline: {
    CalendarEntry(date: .now, days: [])
}
