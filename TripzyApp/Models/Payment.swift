import Foundation
struct Payment: Codable{
    var id: String          // Unique payment ID
    var rideId: String      // Reference to the Ride model
    var userId: String      // Reference to the User model
    var amount: Double
    var paymentMethod: String
    var transactionDate: Date
    var status: String      // Success, Failed, Pending
}
