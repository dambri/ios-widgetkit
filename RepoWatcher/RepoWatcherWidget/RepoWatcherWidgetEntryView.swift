//
//  RepoWatcherWidgetEntryView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import WidgetKit
import SwiftUI

struct RepoWatcherWidgetEntryView: View {
    var entry: RepoEntry
    private let formatter = ISO8601DateFormatter()
    private var daySinceLastActivity: Int {
        calculateDaysSinceLastActivity(from: entry.repo.pushedAt)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .frame(width: 50, height: 50)
                    
                    Text(entry.repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                }
                .padding(.bottom, 6)
                
                HStack {
                    StatLabelView(value: entry.repo.watchers, systemImageName: "star.fill")
                    StatLabelView(value: entry.repo.forks, systemImageName: "tuningfork")
                    StatLabelView(value: entry.repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                }
            }
            
            Spacer()
            
            VStack {
                Text("\(daySinceLastActivity)")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundStyle(daySinceLastActivity > 50 ? .pink : .green)
                
                Text("days ago")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    fileprivate func calculateDaysSinceLastActivity(from dateString: String) -> Int {
        let lastActivityDate = formatter.date(from: dateString) ?? .now
        let daySinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day
        return daySinceLastActivity ?? 0
    }
}

#Preview(as: .systemMedium) {
    RepoWatcherWidget()
} timeline: {
    RepoEntry(date: .now, repo: Repository.placeholder)
}
