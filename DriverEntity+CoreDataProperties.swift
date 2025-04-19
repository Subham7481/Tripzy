//
//  DriverEntity+CoreDataProperties.swift
//  TripzyApp
//
//  Created by Subham Patel on 16/04/25.
//
//

import Foundation
import CoreData


extension DriverEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DriverEntity> {
        return NSFetchRequest<DriverEntity>(entityName: "DriverEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var rating: Double
    @NSManaged public var vehicle: String?
    @NSManaged public var booking: BookingEntity?

}

extension DriverEntity : Identifiable {

}
