//
//  Persistence.swift
//  SwiftCal
//
//  Created by Alexandre D'AMBRISI on 12/08/2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let databaseName = "SwiftCal.sqlite"

    var oldStoreURL: URL {
        let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent(databaseName)
    }

    var sharedStoreURL: URL {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.dambrisi-corp.SwiftCal")!
        return container.appendingPathComponent(databaseName)
    }

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        let startDate = Calendar.current.dateInterval(of: .month, for: .now)!.start

        for dayOffset in 0..<30 {
            let newDay = Day(context: viewContext)
            newDay.date = Calendar.current.date(byAdding: .day, value: dayOffset, to: startDate)
            newDay.didStudy = Bool.random()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SwiftCal")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else if !FileManager.default.fileExists(atPath: oldStoreURL.path) {
            container.persistentStoreDescriptions.first!.url = sharedStoreURL
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        migrateStore(for: container)
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func migrateStore(for container: NSPersistentContainer) {
        let coordinator = container.persistentStoreCoordinator

        guard let oldStore = coordinator.persistentStore(for: oldStoreURL) else { return }

        do {
            let _ = try coordinator.migratePersistentStore(oldStore, to: sharedStoreURL, type: .sqlite)
        } catch {
            fatalError("Unable to migrate to shared store")
        }

        do {
            try FileManager.default.removeItem(at: oldStoreURL)
        } catch {
            print("Unable to delete oldStore")
        }
    }
}

