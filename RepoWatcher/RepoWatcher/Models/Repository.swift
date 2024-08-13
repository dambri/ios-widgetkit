//
//  Repository.swift
//  RepoWatcher
//
//  Created by Alexandre D'AMBRISI on 07/08/2024.
//

import Foundation

struct Repository {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let openIssues: Int
    let watchers: Int
    let forks: Int
    let pushedAt: String
    var avatarData: Data
    var contributors: [Contributor] = []
    
    var daysSinceLastActivity: Int {
        let formatter = ISO8601DateFormatter()
        let lastActivityDate = formatter.date(from: pushedAt) ?? .now
        let daySinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day
        return daySinceLastActivity ?? 0
    }
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
