import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore

class MainViewViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isRegistered: Bool = false
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var errorMessage: String = ""

    init() {
        checkAuthentication()
    }

    func checkAuthentication() {
        if let user = Auth.auth().currentUser {
            DispatchQueue.main.async {
                self.isLoggedIn = true
                self.checkRegistrationStatus(for: user.uid)
            }
        } else {
            DispatchQueue.main.async {
                self.isLoggedIn = false
                self.isRegistered = false
                self.clearUserData()
            }
        }
    }

    private func checkRegistrationStatus(for uid: String) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { [weak self] document, error in
            if let document = document, document.exists {
                self?.isRegistered = true
                self?.fetchUserDetails(for: uid)
            } else {
                self?.isRegistered = false
                self?.clearUserData()
            }
        }
    }

    private func fetchUserDetails(for uid: String) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { [weak self] document, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = "Error fetching user data: \(error.localizedDescription)"
                }
                return
            }

            if let data = document?.data() {
                DispatchQueue.main.async {
                    self?.userName = data["name"] as? String ?? "Unknown"
                    self?.userEmail = data["email"] as? String ?? "Unknown"
                }
            } else {
                DispatchQueue.main.async {
                    self?.clearUserData()
                }
            }
        }
    }

    private func clearUserData() {
        userName = ""
        userEmail = ""
        errorMessage = ""
    }

    func logout() {
        if !isLoggedIn {
            print("Logout called when already logged out.")
            return
        }

        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isLoggedIn = false
                self.isRegistered = false
                self.clearUserData()
            }
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
