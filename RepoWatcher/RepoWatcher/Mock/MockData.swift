//
//  MockData.swift
//  RepoWatcher
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import Foundation

struct MockData {
    static let repoOne = Repository(name: "Repository 1",
                                    owner: Owner(avatarUrl: ""),
                                    hasIssues: true,
                                    openIssues: 65,
                                    watchers: 123,
                                    forks: 55,
                                    pushedAt: "2023-08-09T18:19:30Z",
                                    avatarData: Data())
    
    static let repoTwo = Repository(name: "Repository 2",
                                    owner: Owner(avatarUrl: ""),
                                    hasIssues: false,
                                    openIssues: 120,
                                    watchers: 999,
                                    forks: 125,
                                    pushedAt: "2024-07-09T18:19:30Z",
                                    avatarData: Data())
}
