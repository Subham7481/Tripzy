//
//  Driver.swift
//  TripzyApp
//
//  Created by Subham Patel on 05/01/25.
//

import Foundation
struct Location: Codable {
    var latitude: Double
    var longitude: Double
}

struct DriverDetails: Codable {
    var id: UUID         // Unique driver ID (from Firebase Auth)
    var name: String
    var email: String
    var phoneNumber: String
    var vehicle: String
    var currentLocation: Location?
    var rating: Double
}
