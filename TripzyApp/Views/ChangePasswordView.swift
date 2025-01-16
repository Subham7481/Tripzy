import SwiftUI

struct PasswordFieldWithToggle: View {
    @Binding var password: String
    @State private var isPasswordVisible: Bool = false

    var placeholder: String

    var body: some View {
        HStack {
            if isPasswordVisible {
                TextField(placeholder, text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
            } else {
                SecureField(placeholder, text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
            }

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
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""

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

            PasswordFieldWithToggle(password: $oldPassword, placeholder: "Old Password")
                .padding(.bottom, 20)

            PasswordFieldWithToggle(password: $newPassword, placeholder: "New Password")
                .padding(.bottom, 20)

            PasswordFieldWithToggle(password: $confirmPassword, placeholder: "Confirm Password")
                .padding(.bottom, 40)

            Button(action: {
                // Save password action
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
    }
}

#Preview {
    ChangePasswordView()
}
