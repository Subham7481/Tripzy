import Foundation
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth

class ProfileViewViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var address: String = ""
    @Published var phoneNumber: String = ""
    @Published var selectedGender: String = "Male"
    @Published var selectedCountry: Country = Country(name: "India", code: "+91", flag: "🇮🇳")
    @Published var profileImage: UIImage? = UIImage(systemName: "person.circle")
    @Published var profileImageData: Data?

    private let databaseRef = Database.database().reference()
    private let storageRef = Storage.storage().reference()

    func saveProfileData() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User is not authenticated.")
            return
        }
        
        guard let profileImageData = profileImageData else {
            print("Error: No profile image selected.")
            saveProfileInfo(imageURL: nil, userID: userID) // Save data without an image
            return
        }
        
        uploadProfileImage(data: profileImageData, userID: userID)
    }
    
    // MARK: - Upload Image to Firebase Storage
    private func uploadProfileImage(data: Data, userID: String) {
        let imagePath = "profile_images/\(UUID().uuidString).jpg"
        let imageRef = storageRef.child(imagePath)
        
        imageRef.putData(data, metadata: nil) { [weak self] metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    print("Error retrieving image URL: \(error.localizedDescription)")
                    return
                }
                
                guard let imageURL = url?.absoluteString else {
                    print("Error: Image URL is nil.")
                    return
                }
                
                self?.saveProfileInfo(imageURL: imageURL, userID: userID)
            }
        }
    }
    
    private func saveProfileInfo(imageURL: String?, userID: String) {
        let profileData: [String: Any] = [
            "name": name,
            "email": email,
            "address": address,
            "phoneNumber": "\(selectedCountry.code) \(phoneNumber)",
            "gender": selectedGender,
            "profileImageURL": imageURL ?? ""
        ]
        
        databaseRef.child("users").child(userID).setValue(profileData) { error, _ in
            if let error = error {
                print("Failed to save profile data: \(error.localizedDescription)")
            } else {
                print("Profile data saved successfully.")
            }
        }
    }
    
    func resetProfileImage() {
           profileImage = nil
           profileImageData = nil
    }
}
