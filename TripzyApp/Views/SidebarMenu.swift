import SwiftUI

struct SidebarMenu: View {
    @ObservedObject var viewModel : MainViewViewModel
    @Binding var isSidebarOpen: Bool

    struct MenuItem{
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
        VStack(alignment: .leading) {
            VStack {
                if viewModel.isLoggedIn && viewModel.isRegistered{
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .foregroundColor(Color.green.opacity(0.7))
                        .padding()
                        .padding(.top, 20)
                    
                    Text("Welcome, \(viewModel.userName)")
                    Text(viewModel.userEmail)
                }
                    else if !viewModel.errorMessage.isEmpty {
                                    Text(viewModel.errorMessage)
                                        .foregroundColor(.red)
                    }
            }
            
            VStack(alignment: .leading, spacing: 10){
                ForEach(menuItems, id: \.title) { item in
                    VStack{
                        NavigationLink(destination: item.destination){
                            HStack(spacing: 15){
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
                    
                    
            Button(action: {
                viewModel.logout()
                isSidebarOpen = false
            }) {
                ZStack{
                    HStack{
                        Image(systemName: "power")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        
                        Text("Logout")
                            .foregroundColor(.black)
                            .padding(.horizontal, 25)
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.bottom, 200)
            Spacer()
        }
        .padding()
        .background(Color.white)
    }
}

struct SidebarMenu_Previews: PreviewProvider {
    static var previews: some View {
        SidebarMenu(viewModel: MainViewViewModel(), isSidebarOpen: .constant(true))
    }
}
