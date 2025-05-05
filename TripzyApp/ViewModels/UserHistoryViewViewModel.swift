//
//  UserHistoryViewViewModel.swift
//  TripzyApp
//
//  Created by Subham Patel on 22/10/24.
//

import Foundation
import CoreData
class UserHistoryViewViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    
    @Published var upcomingRides: [BookingEntity] = []
    @Published var completedRides: [BookingEntity] = []
    @Published var bookingDriverDetails: [DriverEntity] = []
    @Published var bookingRideDetails: [BookingEntity] = []
    @Published var drivers: [String] = ["John", "Emma", "Ravi", "Anita", "David"]

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchDrivers()
        fetchRideDetails()
        assignRandomDrivers()
    }

    func fetchDrivers() {
        bookingDriverDetails = CoreDataManager.shared.fetchDrivers()
    }

    func fetchRideDetails() {
           let fetchRequest: NSFetchRequest<BookingEntity> = BookingEntity.fetchRequest()
           do {
               bookingRideDetails = try context.fetch(fetchRequest)

               let now = Date()
               let oneHourAgo = now.addingTimeInterval(-3600)
               
               upcomingRides = bookingRideDetails.filter {
                   guard let date = $0.timeStamp else { return false }
                   return date > oneHourAgo
               }
               
               completedRides = bookingRideDetails.filter {
                   guard let date = $0.timeStamp else { return false }
                   return date <= oneHourAgo
               }

               assignRandomDrivers()

               print("Fetched Rides: \(bookingRideDetails.count)")
               print("Upcoming Rides: \(upcomingRides.count)")
               print("Completed Rides: \(completedRides.count)")
           } catch {
               print("Error fetching rides: \(error)")
           }
    }

    func assignRandomDrivers() {
        let allRides = upcomingRides + completedRides
        for ride in allRides {
            if ride.driverName == nil {
                ride.driverName = drivers.randomElement()
                try? context.save()
            }
        }
    }
}

