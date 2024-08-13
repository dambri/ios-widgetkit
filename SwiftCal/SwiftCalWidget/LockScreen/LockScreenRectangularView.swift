//
//  LockScreenRectangularView.swift
//  SwiftCalWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 13/08/2024.
//

import SwiftUI
import WidgetKit

struct LockScreenRectangularView: View {
    var entry: CalendarEntry
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 4) {
            ForEach(entry.days) { day in
                if day.date!.monthInt != Date().monthInt {
                    Text("")
                        .font(.system(size: 7))
                } else {
                    if day.didStudy {
                        Image(systemName: "swift")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 7, height: 7)
                    } else {
                        Text("\(day.date!.formatted(.dateTime.day()))")
                            .font(.system(size: 7))
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

#Preview(as: .accessoryRectangular) {
    SwiftCalWidget()
} timeline: {
    CalendarEntry(date: .now, days: [])
}
