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
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let databaseRef = Database.database().reference()
    private let storageRef = Storage.storage().reference()

    func saveProfileData() {
        guard validateInputs() else { return }
        guard let userID = Auth.auth().currentUser?.uid else {
            handleError("Error: User is not authenticated.")
            return
        }
        
        isLoading = true
        
        if let profileImageData = profileImageData {
            uploadProfileImage(data: profileImageData, userID: userID)
        } else {
            saveProfileInfo(imageURL: nil, userID: userID)
        }
    }
    
    private func uploadProfileImage(data: Data, userID: String) {
        let imagePath = "profile_images/\(userID).jpg"
        let imageRef = storageRef.child(imagePath)
        
        imageRef.putData(data, metadata: nil) { [weak self] metadata, error in
            if let error = error {
                self?.handleError("Error uploading image: \(error.localizedDescription)")
                self?.isLoading = false
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    self?.handleError("Error retrieving image URL: \(error.localizedDescription)")
                    self?.isLoading = false
                    return
                }
                
                guard let imageURL = url?.absoluteString else {
                    self?.handleError("Error: Image URL is nil.")
                    self?.isLoading = false
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
        
        databaseRef.child("users").child(userID).setValue(profileData) { [weak self] error, _ in
            self?.isLoading = false
            if let error = error {
                self?.handleError("Failed to save profile data: \(error.localizedDescription)")
            } else {
                self?.clearFields()
                print("Profile data saved successfully.")
            }
        }
    }
    
    private func handleError(_ error: String) {
        print(error)
        errorMessage = error
    }
    
    private func validateInputs() -> Bool {
        if name.isEmpty || email.isEmpty || address.isEmpty || phoneNumber.isEmpty {
            handleError("All fields are required.")
            return false
        }
        
        if !isValidEmail(email) {
            handleError("Invalid email address.")
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func clearFields() {
        name = ""
        email = ""
        address = ""
        phoneNumber = ""
        selectedGender = "Male"
        profileImage = UIImage(systemName: "person.circle")
        profileImageData = nil
    }
    
    func resetProfileImage() {
        profileImage = nil
        profileImageData = nil
    }
}
