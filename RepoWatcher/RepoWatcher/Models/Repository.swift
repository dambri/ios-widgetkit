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
    var avatarData: Data
    
    static let placeholder = Repository(name: "Your Repo",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: true,
                                        openIssues: 65,
                                        watchers: 123,
                                        forks: 55,
                                        pushedAt: "2022-08-09T18:19:30Z",
                                        avatarData: Data())
}

extension Repository {
    struct CodingData: Decodable {
        let name: String
        let owner: Owner
        let hasIssues: Bool
        let openIssues: Int
        let watchers: Int
        let forks: Int
        let pushedAt: String
        
        var repo: Repository {
            Repository(name: name,
                       owner: owner,
                       hasIssues: hasIssues,
                       openIssues: openIssues,
                       watchers: watchers,
                       forks: forks,
                       pushedAt: pushedAt,
                       avatarData: Data())
        }
    }
}

struct Owner: Decodable {
    let avatarUrl: String
}
