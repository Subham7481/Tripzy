//
//  ChangePasswordViewModel.swift
//  TripzyApp
//
//  Created by Subham Patel on 14/03/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

class ChangePasswordViewModel: ObservableObject {
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String = ""
    @Published var isPasswordChanged: Bool = false

    func changePassword(completion: @escaping (Bool) -> Void) {
        // Input validation
        guard !oldPassword.isEmpty, !newPassword.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "All fields are required."
            completion(false)
            return
        }

        guard newPassword == confirmPassword else {
            errorMessage = "New password and confirm password do not match."
            completion(false)
            return
        }

        guard newPassword.count >= 8 else {
            errorMessage = "New password must be at least 8 characters long."
            completion(false)
            return
        }

        // Firebase Password Change Logic
        guard let currentUser = Auth.auth().currentUser, let email = currentUser.email else {
            errorMessage = "User not logged in."
            completion(false)
            return
        }

        // Reauthenticate the user
        let credential = EmailAuthProvider.credential(withEmail: email, password: oldPassword)
        currentUser.reauthenticate(with: credential) { result, error in
            if let error = error {
                self.errorMessage = "Reauthentication failed: \(error.localizedDescription)"
                completion(false)
            } else {
                // Update the password
                currentUser.updatePassword(to: self.newPassword) { error in
                    if let error = error {
                        self.errorMessage = "Failed to update password: \(error.localizedDescription)"
                        completion(false)
                    } else {
                        self.isPasswordChanged = true
                        completion(true)
                    }
                }
            }
        }
    }
}

