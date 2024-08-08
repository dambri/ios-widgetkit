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
                                    avatarData: Data(),
                                    contributors: [
                                        Contributor(login: "Alex Dambri", avatarUrl: "", contributions: 42, avatarData: Data()),
                                        Contributor(login: "Alessandro Del Piero", avatarUrl: "", contributions: 100, avatarData: Data()),
                                        Contributor(login: "LeBron James", avatarUrl: "", contributions: 53, avatarData: Data()),
                                        Contributor(login: "Lewis Hamilton", avatarUrl: "", contributions: 44, avatarData: Data())
                                    ])
    
    static let repoOneV2 = Repository(name: "Repository 1",
                                      owner: Owner(avatarUrl: ""),
                                      hasIssues: true,
                                      openIssues: 100,
                                      watchers: 345,
                                      forks: 112,
                                      pushedAt: "2023-10-09T18:19:30Z",
                                      avatarData: Data(),
                                      contributors: [
                                            Contributor(login: "Alex Dambri", avatarUrl: "", contributions: 154, avatarData: Data()),
                                            Contributor(login: "Alessandro Del Piero", avatarUrl: "", contributions: 256, avatarData: Data()),
                                            Contributor(login: "LeBron James", avatarUrl: "", contributions: 32, avatarData: Data()),
                                            Contributor(login: "Lewis Hamilton", avatarUrl: "", contributions: 88, avatarData: Data())
                                      ])
    
    static let repoTwo = Repository(name: "Repository 2",
                                    owner: Owner(avatarUrl: ""),
                                    hasIssues: false,
                                    openIssues: 120,
                                    watchers: 999,
                                    forks: 125,
                                    pushedAt: "2024-07-09T18:19:30Z",
                                    avatarData: Data())
}
