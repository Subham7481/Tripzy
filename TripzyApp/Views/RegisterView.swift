import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel = RegisterViewViewModel()
    var onRegisterSuccess: (() -> Void)?
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            HStack{
                Text("Create Account")
                    .bold()
                    .font(.system(size: 20))
                    .padding()
                Spacer()
            }
            Form{
                ScrollView{
//                    Text("Name")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    TextField("Name", text: $viewModel.name)
//                        .textFieldStyle(DefaultTextFieldStyle())
//                        .autocapitalization(.none)
//                        .autocorrectionDisabled()
                    
                    Text("Email")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top,10)
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    Text("Password")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top,10)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        viewModel.register()
                        if viewModel.errorMessage.isEmpty {
                            Text("Registration successful")
                            onRegisterSuccess?()
                            dismiss()
                        }
                    }, label: {
                        Text("Register")
                            .frame(width: 330, height: 50)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    })
                }
            }
            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}
