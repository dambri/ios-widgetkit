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
            VStack {
                Text("30")
                    .font(.system(size: 70, design: .rounded))
                    .bold()
                    .foregroundStyle(.orange)
                
                Text("day streak")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            VStack {
                CalendarHeaderView(font: .caption)
                
                LazyVGrid(columns: columns, spacing: 7) {
                    ForEach(0..<31) { _ in
                        Text("30")
                            .font(.caption2)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.secondary)
                            .background(
                                Circle()
                                    .foregroundStyle(.orange.opacity(0.3))
                                    .scaleEffect(1.5)
                            )
                    }
                }
            }
            .padding(.leading, 6)
        }
        .padding()
    }
}

#Preview(as: .systemMedium) {
    SwiftCalWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
