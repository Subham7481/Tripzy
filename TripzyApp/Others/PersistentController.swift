//
//  PersistentController.swift
//  TripzyApp
//
//  Created by Subham Patel on 16/04/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // ✅ Add this PREVIEW instance
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        // Optional: Add mock data for preview testing
        let viewContext = controller.container.viewContext
        let sampleRide = BookingEntity(context: viewContext)
        sampleRide.startLocation = "Home"
        sampleRide.endLocation = "Airport"
        sampleRide.fareAmount = 120.0
        sampleRide.timeStamp = Date()

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved preview error \(nsError), \(nsError.userInfo)")
        }

        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model") // <- use your actual .xcdatamodeld name here
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved Core Data error \(error), \(error.userInfo)")
            }
        }
    }
}

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
//        let modelName = "Model" // change to your actual .xcdatamodeld filename
//        container = NSPersistentContainer(name: modelName)
//        
//        // Uncomment below only if you're okay resetting Core Data in dev
//        // deletePersistentStore(for: modelName)
//        
//        let description = container.persistentStoreDescriptions.first
//        description?.shouldMigrateStoreAutomatically = true
//        description?.shouldInferMappingModelAutomatically = true
//
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
//
//    // Helper for resetting store
//    private func deletePersistentStore(for name: String) {
//        let storeURL = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("\(name).sqlite")
//        try? FileManager.default.removeItem(at: storeURL)
//        try? FileManager.default.removeItem(at: storeURL.appendingPathExtension("-shm"))
//        try? FileManager.default.removeItem(at: storeURL.appendingPathExtension("-wal"))
//    }
//}


