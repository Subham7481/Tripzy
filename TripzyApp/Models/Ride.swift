//
//  Ride.swift
//  TripzyApp
//
//  Created by Subham Patel on 05/01/25.
//

import Foundation
struct Ride: Codable{
    var id: String          // Unique ride ID
    var userId: String      // Reference to the User model
    var driverId: String?   // Reference to the Driver model (optional for scheduled rides)
    var startLocation: String
    var endLocation: String
    var fare: Double
    var status: String      // Pending, Completed, Cancelled, etc.
    var timestamp: Date
}
