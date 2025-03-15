import SwiftUI
import Firebase
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class MainViewViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isLoggedIn: Bool = false
    @Published var isRegistered: Bool = false
    @Published var userName: String = "Unknown"
    @Published var userEmail: String = "Unknown"
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false  // Loading state
    @Published var photoURL: URL?

    
    private let databaseRef = Database.database().reference()
    private let storageRef = Storage.storage().reference()

    init() {
//        checkAuthentication()
        fetchUserDetails()
    }

    // Check if the user is logged in or not
    func checkAuthentication() {
           isLoggedIn = Auth.auth().currentUser != nil
    }
//    func checkAuthentication() {
//        guard let user = Auth.auth().currentUser else {
//            print("No user is logged in.")
//            DispatchQueue.main.async {
//                self.clearUserData()
//            }
//            return
//        }
//
//        print("User is logged in with UID: \(user.uid)")
//
//        DispatchQueue.main.async {
//            self.isLoggedIn = true
//        }
//
//        // Ensure this is only called once
//        checkRegistrationStatus(for: user.uid)
//    }

//    private func checkRegistrationStatus(for uid: String) {
//        let db = Firestore.firestore()
//
//        db.collection("users").document(uid).getDocument { [weak self] document, error in
//            guard let self = self else { return }
//
//            if let error = error {
//                print("Error checking registration status: \(error.localizedDescription)")
//                DispatchQueue.main.async {
//                    self.isRegistered = false
//                    self.clearUserData()
//                }
//                return
//            }
//
//            if let document = document, document.exists {
//                print("User is registered.")
//                DispatchQueue.main.async {
//                    self.isRegistered = true
//                }
//                self.fetchUserDetails(for: uid)
//            } else {
//                print("User is not registered.")
//                DispatchQueue.main.async {
//                    self.isRegistered = false
//                    self.clearUserData()
//                }
//            }
//        }
//    }

    //Fetch user details from firebase
    func fetchUserDetails() {
        if let currentUser = Auth.auth().currentUser {
            user = currentUser
        }
    }
    
    //Fetch user profile
    func fetchUserProfile() {
            if let user = Auth.auth().currentUser {
                DispatchQueue.main.async {
                    self.photoURL = user.photoURL
                    self.isLoading = false
                }
            } else {
                self.isLoading = false
            }
        }
    
    // Clear the user data
    private func clearUserData() {
        userName = ""
        userEmail = ""
        errorMessage = ""
    }

    // Logout function to sign the user out
    func logout(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true) // Notify success
        } catch let error {
            print("Failed to log out: \(error.localizedDescription)")
            completion(false) // Notify failure
        }
    }
}
