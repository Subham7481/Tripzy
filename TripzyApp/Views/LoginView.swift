import SwiftUI
//import FireBaseAuth

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewViewModel()
    @ObservedObject var viewModell = MainViewViewModel()
    var onLoginSuccess: (() -> Void)?
    var body: some View {
        NavigationView
        {
            VStack{
                HStack{
                    Text("Sign In")
                        .bold()
                        .font(.system(size: 20))
                        .padding()
                    Spacer()
                }
                
                    Form{
                        ScrollView{
                        Text("Email")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("Email Address", text: $viewModel.email)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        
                        Text("Password")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top,10)
                        SecureField("Password",
                                    text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        Button(action: {
                            viewModel.login { success in
                                    if success {
                                        viewModell.isLoggedIn = true
                                        Text("Login successful")
                                    } else {
                                        print(viewModel.errorMessage)
                                    }
                            }
                        }, label: {
                            Text("Log In")
                                .frame(width: 330, height: 50)
                                .background(Color.green)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                        })
                    }
                }
                VStack{
                    Text("New Here?")
                    
                    NavigationLink("Create Account",
                                   destination: RegisterView())
                    
                    Text("or sign in with")
                        .padding()
                    HStack{
                        Button(action: {
                                       if let url = URL(string: "https://www.facebook.com") {
                                           UIApplication.shared.open(url)
                                       }
                                   }) {
                                       Image("Facebook")
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 60, height: 60)
                                           .padding()
                                   }
                        
                        Link(destination: URL(string: "https://www.google.com")!) {
                            Image("Google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 47, height: 47)
                                .cornerRadius(22)
                                .padding()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
