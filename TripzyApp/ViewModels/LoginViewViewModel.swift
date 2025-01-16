import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    init() {}

    func login(completion: @escaping (Bool) -> Void) {
        guard validate() else {
            completion(false)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                // Firebase-specific error handling
                self?.errorMessage = self?.handleFirebaseError(error) ?? "Login failed."
                completion(false)
                return
            }
            
            if result != nil {
                // Login successful
                self?.errorMessage = ""
                completion(true)
            } else {
                // Unlikely case
                self?.errorMessage = "Login failed: Unable to retrieve user ID."
                completion(false)
            }
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email."
            return false
        }
        
        return true
    }
    
    private func handleFirebaseError(_ error: Error) -> String {
        // Check for specific Firebase error codes
        let errorCode = (error as NSError).code
        
        switch errorCode {
        case AuthErrorCode.invalidEmail.rawValue:
            return "The email address is badly formatted."
        case AuthErrorCode.wrongPassword.rawValue:
            return "The password is invalid or incorrect."
        case AuthErrorCode.userNotFound.rawValue:
            return "No user found with this email address."
        case AuthErrorCode.networkError.rawValue:
            return "Network error. Please try again later."
        default:
            return error.localizedDescription
        }
    }
}
