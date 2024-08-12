//
//  Persistence.swift
//  SwiftCal
//
//  Created by Alexandre D'AMBRISI on 12/08/2024.
//

import Foundation
import SwiftData

struct Persistence {
    static var container: ModelContainer {
        let container: ModelContainer = {
            let sharedStoreURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.dambrisi-corp.SwiftCal")!.appendingPathComponent("SwiftCal.sqlite")
            let config = ModelConfiguration(url: sharedStoreURL)
            return try! ModelContainer(for: Day.self, configurations: config)
        }()
        
        return container
    }
}
