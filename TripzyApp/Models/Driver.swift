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

struct Driver: Codable {
    var id: String          // Unique driver ID (from Firebase Auth)
    var name: String
    var email: String
    var phone: String
    var vehicleDetails: String
    var licenseNumber: String
    var profilePictureURL: String?
    var currentLocation: Location?
    var isAvailable: Bool
    var ratings: Double
}
