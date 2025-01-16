import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewViewModel()
    @State private var showLoginSheet = false
    @State private var showRegisterSheet = false
    
    var body: some View {
        if viewModel.isLoggedIn {
            if viewModel.isRegistered {
                HomeView()
            } else {
                Text("User not registered")
            }
        } else {
            NavigationView {
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
                        
                        if viewModel.isLoggedIn {
                            NavigationLink(destination: HomeView()) {
                                Text("Go to Home")
                                    .bold()
                                    .frame(width: 300, height: 50)
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                    .cornerRadius(14)
                            }
                        } else {
                            HStack {
                                Spacer()
                                
                                VStack(spacing: 15) {
                                    // Sign In Button
                                    Button(action: {
                                        showLoginSheet.toggle()
                                    }) {
                                        Text("Sign In")
                                            .bold()
                                            .frame(width: 300, height: 50)
                                            .foregroundColor(.white)
                                            .background(Color.green)
                                            .cornerRadius(14)
                                    }
                                    .padding()
                                    .sheet(isPresented: $showLoginSheet) {
                                        LoginView()
                                            .presentationDetents([.fraction(0.75)])
                                    }
                                    
                                    // Sign Up Button
                                    Button(action: {
                                        showRegisterSheet.toggle()
                                    }) {
                                        Text("Sign Up")
                                            .bold()
                                            .frame(width: 300, height: 50)
                                            .foregroundColor(.white)
                                            .background(Color.green)
                                            .cornerRadius(14)
                                    }
                                    .padding()
                                    .sheet(isPresented: $showRegisterSheet) {
                                        RegisterView()
                                            .presentationDetents([.fraction(0.75)])
                                    }
                                }
                                .padding(.trailing, 20)
                                .padding(.bottom, 30)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
