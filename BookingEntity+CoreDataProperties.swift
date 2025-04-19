//
//  BookingEntity+CoreDataProperties.swift
//  TripzyApp
//
//  Created by Subham Patel on 16/04/25.
//
//

import Foundation
import CoreData


extension BookingEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookingEntity> {
        return NSFetchRequest<BookingEntity>(entityName: "BookingEntity")
    }

    @NSManaged public var driverName: String?
    @NSManaged public var startLocation: String?
    @NSManaged public var endLocation: String?
    @NSManaged public var fareAmount: Double
    @NSManaged public var id: UUID?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var driver: DriverEntity?

}

extension BookingEntity : Identifiable {

}
