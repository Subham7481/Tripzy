//
//  User.swift
//  TripzyApp
//
//  Created by Subham Patel on 05/01/25.
//

import Foundation
struct AppUser: Codable{
        var uid: String    //from firebase auth
//        var name: String
        var email: String
        var phone: String
        var joined:TimeInterval
        var profilePictureURL: String?
        var homeAddress: String?
        var preferredPayment: String?
    
    func asDictionary() -> [String: Any] {
            return [
                "uid": uid,
//                "name": name,
                "email": email,
                "joined": joined
            ]
    }
}
