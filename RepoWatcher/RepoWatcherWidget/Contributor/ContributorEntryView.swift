//
//  ContributorEntryView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import SwiftUI
import WidgetKit

struct ContributorEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: ContributorEntry

    var body: some View {
        VStack {
            if family == .systemLarge {
                RepoMediumView(repo: entry.repo)
                Spacer().frame(height: 40)
            }
            ContributorMediumView(repo: entry.repo)
        }
        .containerBackground(for: .widget) { }
    }
}

#Preview(as: .systemLarge) {
    ContributorWidget()
} timeline: {
    ContributorEntry(date: .now, repo: MockData.repoOne)
    ContributorEntry(date: .now, repo: MockData.repoOneV2)
}
