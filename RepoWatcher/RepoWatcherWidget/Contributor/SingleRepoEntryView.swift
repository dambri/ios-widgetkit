//
//  ContributorEntryView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import SwiftUI
import WidgetKit

struct SingleRepoEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: SingleRepoEntry

    var body: some View {
        switch family {
            case .systemSmall, .systemExtraLarge, .accessoryCorner, .accessoryCircular, .accessoryRectangular, .accessoryInline:
                EmptyView()
            case .systemMedium:
                RepoMediumView(repo: entry.repo)
                    .containerBackground(for: .widget) { }
            case .systemLarge:
                VStack {
                    RepoMediumView(repo: entry.repo)
                    Spacer().frame(height: 40)
                    ContributorMediumView(repo: entry.repo)
                }
                .containerBackground(for: .widget) { }
            @unknown default:
                EmptyView()
            }
        }
}

#Preview(as: .systemLarge) {
    SingleRepoWidget()
} timeline: {
    SingleRepoEntry(date: .now, repo: MockData.repoOne)
    SingleRepoEntry(date: .now, repo: MockData.repoOneV2)
}
