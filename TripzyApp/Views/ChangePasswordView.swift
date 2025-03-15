import SwiftUI

// Custom Password Field with Toggle for Visibility
struct PasswordFieldWithToggle: View {
    @Binding var password: String
    @State private var isPasswordVisible: Bool = false
    var placeholder: String

    var body: some View {
        HStack {
            // Toggle between TextField and SecureField based on password visibility
            if isPasswordVisible {
                TextField(placeholder, text: $password)
                    .padding()
                    .background(Color.white)
                    .frame(width: 330, height: 70)
                    .cornerRadius(10)
            } else {
                SecureField(placeholder, text: $password)
                    .padding()
                    .background(Color.white)
                    .frame(width: 330, height: 70)
                    .cornerRadius(10)
            }

            // Button to toggle password visibility
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
        .frame(width: 360, height: 60)
    }
}

struct ChangePasswordView: View {
    @StateObject private var viewModel = ChangePasswordViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Change Password")
                    .font(.headline)
                    .padding(.horizontal, 10)
                Spacer()
            }
            .padding()
            .padding(.bottom, 30)

            // Password fields using the PasswordFieldWithToggle
            PasswordFieldWithToggle(password: $viewModel.oldPassword, placeholder: "Old Password")
                .padding(.bottom, 20)

            PasswordFieldWithToggle(password: $viewModel.newPassword, placeholder: "New Password")
                .padding(.bottom, 20)

            PasswordFieldWithToggle(password: $viewModel.confirmPassword, placeholder: "Confirm Password")
                .padding(.bottom, 40)

            // Display error message if any
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
            }

            // Save Button
            Button(action: {
                viewModel.changePassword { success in
                    if success {
                        print("Password changed successfully.")
                    }
                }
            }, label: {
                Text("Save")
                    .font(.headline)
                    .frame(width: 350, height: 55)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })

            Spacer()
        }
        .padding()
        .alert(isPresented: $viewModel.isPasswordChanged) {
            Alert(
                title: Text("Success"),
                message: Text("Your password has been updated successfully."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ChangePasswordView()
}
