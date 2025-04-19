//
//  CoreDataManager.swift
//  TripzyApp
//
//  Created by Subham Patel on 16/04/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "Model") // Use your actual Core Data model name
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load Core Data: \(error)")
            }
        }
    }

    func saveDriver(details: DriverDetails) {
        let context = persistentContainer.viewContext
        let driver = DriverEntity(context: context)
        driver.id = details.id
        driver.name = details.name
        driver.email = details.email
        driver.phoneNumber = details.phoneNumber
        driver.vehicle = details.vehicle
        driver.rating = details.rating

        do {
            try context.save()
            print("Driver \(details.name) saved successfully!")
        } catch {
            print("Failed to save driver: \(error)")
        }
    }

    func fetchDrivers() -> [DriverEntity] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<DriverEntity> = DriverEntity.fetchRequest()

        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch drivers: \(error)")
            return []
        }
    }
}
