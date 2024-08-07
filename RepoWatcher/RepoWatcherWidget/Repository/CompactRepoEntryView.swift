//
//  RepoWatcherWidgetEntryView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import WidgetKit
import SwiftUI

struct CompactRepoEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: CompactRepoEntry

    var body: some View {
        switch family {
            case .systemMedium:
                RepoMediumView(repo: entry.repo)
            case .systemLarge:
                VStack(spacing: 36) {
                    RepoMediumView(repo: entry.repo)
                    if let bottomRepo = entry.bottomRepo {
                        RepoMediumView(repo: bottomRepo)
                    }
                }
            case .systemSmall, .systemExtraLarge, .accessoryInline, .accessoryCircular, .accessoryRectangular:
                EmptyView()
            @unknown default:
                EmptyView()
        }
    }
}

#Preview(as: .systemLarge) {
    CompactRepoWidget()
} timeline: {
    CompactRepoEntry(date: .now, repo: MockData.repoOne, bottomRepo: MockData.repoTwo)
}
