//
//  Repository.swift
//  RepoWatcher
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let openIssues: Int
    let watchers: Int
    let forks: Int
    let pushedAt: String
    
    static let placeholder = Repository(name: "Your Repo",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: true,
                                        openIssues: 65,
                                        watchers: 123,
                                        forks: 55,
                                        pushedAt: "2022-08-09T18:19:30Z")
}

struct Owner: Decodable {
    let avatarUrl: String
}
