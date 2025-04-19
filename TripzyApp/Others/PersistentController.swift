//
//  PersistentController.swift
//  TripzyApp
//
//  Created by Subham Patel on 16/04/25.
//

//import Foundation
//import CoreData
//
//struct PersistenceController {
//    static let shared = PersistenceController()
//
//    let container: NSPersistentContainer
//
//    init() {
//        container = NSPersistentContainer(name: "Model") // Use your .xcdatamodeld file name
//        container.loadPersistentStores { _, error in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//    }
//
//    var context: NSManagedObjectContext {
//        return container.viewContext
//    }
//}

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        let modelName = "Model" // change to your actual .xcdatamodeld filename
        container = NSPersistentContainer(name: modelName)
        
        // Uncomment below only if you're okay resetting Core Data in dev
        // deletePersistentStore(for: modelName)
        
        let description = container.persistentStoreDescriptions.first
        description?.shouldMigrateStoreAutomatically = true
        description?.shouldInferMappingModelAutomatically = true

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    // Helper for resetting store
    private func deletePersistentStore(for name: String) {
        let storeURL = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("\(name).sqlite")
        try? FileManager.default.removeItem(at: storeURL)
        try? FileManager.default.removeItem(at: storeURL.appendingPathExtension("-shm"))
        try? FileManager.default.removeItem(at: storeURL.appendingPathExtension("-wal"))
    }
}


