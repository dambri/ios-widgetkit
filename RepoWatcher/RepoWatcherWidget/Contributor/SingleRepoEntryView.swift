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
            case .systemSmall, .systemExtraLarge, .accessoryCorner:
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
            case .accessoryInline:
                widgetInlineView
            case .accessoryCircular:
                widgetCircularView
            case .accessoryRectangular:
                widgetRectangularView
            @unknown default:
                EmptyView()
        }
    }
    
    @ViewBuilder
    private var widgetInlineView: some View {
        Text("\(entry.repo.name) - \(entry.repo.daysSinceLastActivity) days")
    }
    
    @ViewBuilder
    private var widgetCircularView: some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack {
                Text("\(entry.repo.daysSinceLastActivity)")
                    .font(.headline)
                Text("days")
                    .font(.caption)
            }
        }
    }
    
    @ViewBuilder
    private var widgetRectangularView: some View {
        VStack(alignment: .leading) {
            Text(entry.repo.name)
                .font(.headline)
            
            Text("\(entry.repo.daysSinceLastActivity) days")
            
            HStack {
                widgetImageView(data: entry.repo.watchers, imageName: "star.fill")
                widgetImageView(data: entry.repo.forks, imageName: "tuningfork")
                if entry.repo.hasIssues {
                    widgetImageView(data: entry.repo.openIssues, imageName: "exclamationmark.triangle.fill")
                }
            }
            .font(.caption)
        }
    }
    
    @ViewBuilder
    private func widgetImageView(data: Int, imageName: String) -> some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: 12, height: 12)
            .aspectRatio(contentMode: .fit)
        
        Text("\(data)")
    }
}

#Preview(as: .accessoryCircular) {
    SingleRepoWidget()
} timeline: {
    SingleRepoEntry(date: .now, repo: MockData.repoOne)
    SingleRepoEntry(date: .now, repo: MockData.repoOneV2)
}
