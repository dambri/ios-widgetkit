//
//  UserDefaults+Ext.swift
//  RepoWatcher
//
//  Created by Alexandre D'AMBRISI on 08/08/2024.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        UserDefaults(suiteName: "group.dambri-corp.RepoWatcher")!
    }
    
    static let repoKey = "repos"
}
