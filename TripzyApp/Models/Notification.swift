import Foundation
struct Notification: Codable{
    var id: String          // Unique notification ID
    var userId: String      // Reference to the User model
    var message: String
    var isRead: Bool
    var timestamp: Date
}
