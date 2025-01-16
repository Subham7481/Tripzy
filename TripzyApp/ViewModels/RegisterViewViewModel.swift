import Foundation
import FirebaseFirestore
import FirebaseAuth
class RegisterViewViewModel: ObservableObject{
//    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var phone = ""
    @Published var errorMessage = ""
    
    init() {}
    func register() {
            guard validate() else {
                return
            }
            
            // Register user with Firebase Authentication
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                if let error = error {
                    // Handle Firebase errors (e.g., email already in use, weak password)
                    self?.errorMessage = "Registration failed: \(error.localizedDescription)"
                    return
                }
                
                // Proceed if user creation was successful
                guard let userId = result?.user.uid else {
                    self?.errorMessage = "Invalid credentials"
                    return
                }
                
                // Insert user data into Firestore
                self?.insertUserRecord(id: userId)
            }
        }
    
    private func insertUserRecord(id: String) {
        let newUser = User(uid: id, email: email, phone: phone, joined: Date().timeIntervalSince1970)
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(id)
                .setData(newUser.asDictionary()) { [weak self] error in
                    if let error = error {
                        self?.errorMessage = "Failed to save user data: \(error.localizedDescription)"
                    } else {
                        // Optionally, handle successful registration (e.g., navigate to another screen)
                        self?.errorMessage = ""
                    }
                }
        }
    private func validate() -> Bool {
           // Check if fields are empty
           guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                 !password.trimmingCharacters(in: .whitespaces).isEmpty else {
               errorMessage = "Please fill in all fields."
               return false
           }
           
           // Validate email format
           guard email.contains("@") && email.contains(".") else {
               errorMessage = "Please enter a valid email address."
               return false
           }
           
           // Check password length
           guard password.count >= 6 else {
               errorMessage = "Password should be at least 6 characters long."
               return false
           }
           
           return true
       }
}
