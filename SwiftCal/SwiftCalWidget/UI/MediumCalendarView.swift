//
//  MediumCalendarView.swift
//  SwiftCalWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 13/08/2024.
//

import SwiftUI
import WidgetKit

struct MediumCalendarView: View {
    var entry: Provider.Entry
    var streakValue: Int
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        HStack {
            Link(destination: URL(string: "streak")!) {
                VStack {
                    Text("\(streakValue))")
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
}

#Preview(as: .systemMedium) {
    SwiftCalWidget()
} timeline: {
    CalendarEntry(date: .now, days: [])
}
