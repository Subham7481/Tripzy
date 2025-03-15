//
//  ComplainViewViewModel.swift
//  TripzyApp
//
//  Created by Subham Patel on 14/03/25.
//

import Foundation
import Firebase

class ComplainViewViewModel: ObservableObject {
    @Published var isSubmitted: Bool = false
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    func submitComplaint(selectedComplaint: String, complaintText: String) {
        guard selectedComplaint != "Select a Complaint" else {
            showError = true
            errorMessage = "Please select a complaint type."
            return
        }
        
        guard complaintText.count >= 10 else {
            showError = true
            errorMessage = "Complaint must be at least 10 characters long."
            return
        }

        isLoading = true
        errorMessage = ""

        // Prepare Data
        let complaintId = UUID().uuidString
        let database = Database.database().reference()
        let complaintData: [String: Any] = [
            "complaintType": selectedComplaint,
            "complaintText": complaintText,
            "timestamp": Date().timeIntervalSince1970
        ]

        // Save to Firebase
        database.child("complaints").child(complaintId).setValue(complaintData) { error, _ in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.showError = true
                    self.errorMessage = "Failed to submit complaint: \(error.localizedDescription)"
                } else {
                    self.isSubmitted = true
                }
            }
        }
    }
}
