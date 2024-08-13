//
//  ContributorWidget.swift
//  RepoWatcher
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import SwiftUI
import WidgetKit

struct SingleRepoProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SingleRepoEntry {
        SingleRepoEntry(date: .now, repo: MockData.repoOne)
    }
    
    func snapshot(for configuration: SelectSingleRepo, in context: Context) async -> SingleRepoEntry {
        return SingleRepoEntry(date: .now, repo: MockData.repoOne)
    }
    
    func timeline(for configuration: SelectSingleRepo, in context: Context) async -> Timeline<SingleRepoEntry> {
        let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
        
        do {
            // Get Repo
            let repoToShow = RepoURL.prefix + (configuration.repo ?? "")
            var repo = try await NetworkManager.shared.getRepo(atUrl: repoToShow)
            let avatarData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
            repo.avatarData = avatarData ?? Data()
            
            if context.family == .systemLarge {
                // Get Contributors
                let contributors = try await NetworkManager.shared.getContributors(atUrl: repoToShow + RepoURL.contributors)
                
                // Filter to just the top 4
                var topFour = Array(contributors.prefix(4))
                
                // Download top four avatars
                for i in topFour.indices {
                    let avatarData = await NetworkManager.shared.downloadImageData(from: topFour[i].avatarUrl)
                    topFour[i].avatarData = avatarData ?? Data()
                }
                
                repo.contributors = topFour
            }
            
            // Create Entry & Timeline
            let entry = SingleRepoEntry(date: .now, repo: repo)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        } catch {
            print("❌ Error - \(error.localizedDescription)")
            return Timeline(entries: [], policy: .after(nextUpdate))
        }
    }
}

struct SingleRepoEntry: TimelineEntry {
    var date: Date
    let repo: Repository
}

@main
struct SingleRepoWidget: Widget {
    let kind: String = "SingleRepoWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectSingleRepo.self, provider: SingleRepoProvider()) { entry in
            if #available(iOS 17.0, *) {
                SingleRepoEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SingleRepoEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Single Repo")
        .description("Track a single repository's top contributors.")
        .supportedFamilies([.systemLarge,.systemMedium, .accessoryInline, .accessoryRectangular, .accessoryCircular])
    }
}
