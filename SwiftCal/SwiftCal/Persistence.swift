//
//  Persistence.swift
//  SwiftCal
//
//  Created by Alexandre D'AMBRISI on 12/08/2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    private let dataBaseName = "SwiftCal.sqlite"
    private var oldStoreURl: URL {
        let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        return directory.appending(path: dataBaseName, directoryHint: .isDirectory)
    }
    
    private var sharedStoreURL: URL {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.dambrisi-corp.SwiftCal")
        return container!.appending(path: dataBaseName, directoryHint: .isDirectory)
    }

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let startDate = Calendar.current.dateInterval(of: .month, for: .now)!.start
        
        for dayOffset in 0..<30 {
            let newItem = Day(context: viewContext)
            newItem.date = Calendar.current.date(byAdding: .day, value: dayOffset, to: startDate)
            newItem.didStudy = Bool.random()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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
        } else {
            container.persistentStoreDescriptions.first!.url = sharedStoreURL
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        migrateStore(for: container)
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func migrateStore(for container: NSPersistentContainer) {
        print("➡️ went into migrateStore")
        let coordinator = container.persistentStoreCoordinator
        
        guard let oldStore = coordinator.persistentStore(for: oldStoreURl) else {
            return
        }
        print("old store no longer exists")
        
        do {
            let _ = try coordinator.migratePersistentStore(oldStore, to: sharedStoreURL, type: .sqlite)
            print("🏁 Migration succesful")
        } catch {
            fatalError("Unable to migrate to shared store")
        }
        
        do {
            try FileManager.default.removeItem(at: oldStoreURl)
            print("🗑️ old store deleted")
        } catch {
            print("Unable to delete oldStore")
        }
    }
}
