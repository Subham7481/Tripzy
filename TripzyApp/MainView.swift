import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewViewModel()
    @State private var navigateToLogin = false
    @State private var navigateToRegister = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                // Background Image
                Image("PalmTreee")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("Let's Ride!")
                            .italic()
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                            .foregroundColor(.red)
                            .font(.system(size: 35))
                    }
                    
                    Spacer()
                    HStack {
                        Spacer()
                        
                        VStack(spacing: 15) {
                            // Sign In Button
                            NavigationLink("", destination: LoginView(), isActive: $navigateToLogin)
                            Button(action: {
                                navigateToLogin = true
                            }) {
                                Text("Sign In")
                                    .bold()
                                    .frame(width: 300, height: 50)
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                    .cornerRadius(14)
                            }
                            .padding()
                            
                            // Sign Up Button
                            NavigationLink("", destination: RegisterView(), isActive: $navigateToRegister)
                            Button(action: {
                                navigateToRegister = true
                            }) {
                                Text("Sign Up")
                                    .bold()
                                    .frame(width: 300, height: 50)
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                    .cornerRadius(14)
                            }
                            .padding()
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MainView()
}
