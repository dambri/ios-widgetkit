//
//  RepoMediumView.swift
//  RepoWatcher
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
    let repo: Repository
    private var daySinceLastActivity: Int {
        repo.daysSinceLastActivity
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: UIImage(data: repo.avatarData) ?? UIImage(named: "avatar")!)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                    Text(repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                }
                .padding(.bottom, 6)
                
                HStack {
                    StatLabelView(value: repo.watchers, systemImageName: "star.fill")
                    StatLabelView(value: repo.forks, systemImageName: "tuningfork")
                    if repo.hasIssues {
                        StatLabelView(value: repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                    }
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
                    .contentTransition(.numericText())
                    .frame(width: 90, height: 90)
                
                Text("days ago")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .containerBackground(for: .widget) { }
    }
}

#Preview(as: .systemMedium) {
    SingleRepoWidget()
} timeline: {
    SingleRepoEntry(date: .now, repo: MockData.repoOne)
    SingleRepoEntry(date: .now, repo: MockData.repoOneV2)
}
