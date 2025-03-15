import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

struct SidebarMenu: View {
    @ObservedObject var viewModel: MainViewViewModel
    @Binding var isSidebarOpen: Bool
    @State private var navigateToMainView = false

    var body: some View {
        VStack(alignment: .leading) {
            ProfileSection(viewModel: viewModel)
                .padding(.top, 100)
            MenuItemsSection()
            LogoutButton(viewModel: viewModel, navigateToMainView: $navigateToMainView)
            Spacer()
        }
        .padding()
        .background(Color.white)
    }
}

struct ProfileSection: View {
    @ObservedObject var viewModel: MainViewViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                       Image(systemName: "person.circle.fill")
                           .resizable()
                           .scaledToFill()
                           .frame(width: 100, height: 100)
                           .clipShape(Circle())
                           .overlay(Circle().stroke(Color.white, lineWidth: 4))
                           .shadow(radius: 10)
                           .foregroundColor(.gray)
                   } else {
                       if let url = viewModel.photoURL {
                           AsyncImage(url: url) { phase in
                               if let image = phase.image {
                                   image
                                       .resizable()
                                       .scaledToFill()
                                       .frame(width: 100, height: 100)
                                       .clipShape(Circle())
                                       .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                       .shadow(radius: 10)
                               } else {
                                   Image(systemName: "person.circle.fill")
                                       .resizable()
                                       .scaledToFill()
                                       .frame(width: 100, height: 100)
                                       .clipShape(Circle())
                                       .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                       .shadow(radius: 10)
                                       .foregroundColor(.gray)
                               }
                           }
                       } else {
                           Image(systemName: "person.circle.fill")
                               .resizable()
                               .scaledToFill()
                               .frame(width: 100, height: 100)
                               .clipShape(Circle())
                               .overlay(Circle().stroke(Color.white, lineWidth: 4))
                               .shadow(radius: 10)
                               .foregroundColor(.gray)
                    }
            }

            if let user = viewModel.user {
                Text("Welcome, \(user.displayName ?? "User")")
                    .font(.title)
                
                Text("Email: \(user.email ?? "No email")")
                    .font(.subheadline)
            }

            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            if !viewModel.isLoggedIn {
                viewModel.checkAuthentication()
            }
        }
    }
}

struct MenuItemsSection: View {
    struct MenuItem {
        var title: String
        var imageName: String
        var destination: AnyView
    }

    let menuItems: [MenuItem] = [
        MenuItem(title: "History", imageName: "clock.fill", destination: AnyView(UserHistoryView())),
        MenuItem(title: "Complain", imageName: "exclamationmark.triangle.fill", destination: AnyView(ComplainView())),
        MenuItem(title: "About Us", imageName: "info.circle.fill", destination: AnyView(AboutUsView())),
        MenuItem(title: "Help And Support", imageName: "questionmark.circle.fill", destination: AnyView(HelpView())),
        MenuItem(title: "Settings", imageName: "gearshape.fill", destination: AnyView(SettingsView()))
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(menuItems, id: \.title) { item in
                VStack {
                    NavigationLink(destination: item.destination) {
                        HStack(spacing: 15) {
                            Image(systemName: item.imageName)
                                .foregroundColor(.black)
                                .font(.system(size: 20))

                            Text(item.title)
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .padding()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                    }
                    Divider()
                }
            }
            .background(Color.gray.opacity(0.1))
        }
    }
}

struct LogoutButton: View {
    @ObservedObject var viewModel: MainViewViewModel
    @Binding var navigateToMainView: Bool

    var body: some View {
            Button(action: {
                viewModel.logout { success in
                    if success {
                        navigateToMainView = true
                        print("Log out successful.")
                    } else {
                        print("Logout failed")
                    }
                }
            }) {
                HStack {
                    Image(systemName: "power")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                    
                    Text("Logout")
                        .foregroundColor(.black)
                        .padding(.horizontal, 25)
                }
            }
            .background(
                NavigationLink("", destination: MainView(), isActive: $navigateToMainView)
            )
            .padding(.vertical, 10)
            .padding(.bottom, 200)
    }
}

struct SidebarMenu_Previews: PreviewProvider {
    static var previews: some View {
        SidebarMenu(viewModel: MainViewViewModel(), isSidebarOpen: .constant(true))
    }
}
