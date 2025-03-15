import SwiftUI
import MapKit

struct TabBarItem{
    let name: String
    let image: String
}

struct HomeView: View {
    @ObservedObject var viewModel = MainViewViewModel()
    @State private var search = ""
    @State private var isActive = false
    @State private var selectedTab = 0
    let tabbaritems: [TabBarItem] = [
        TabBarItem(name: "Home", image: "house"),
        TabBarItem(name: "Offers", image: "tag.fill"),
        TabBarItem(name: "Notifications", image: "bell.fill"),
        TabBarItem(name: "Profile", image: "person.circle.fill"),
        TabBarItem(name: "History", image: "arrow.counterclockwise.circle.fill")
    ]
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        VStack {
            // Main View Content
            ZStack {
                if selectedTab == 0 {
                    MainHomeView(region: $region, search: $search, isActive: $isActive)
                } else if selectedTab == 1 {
                    OfferView()
                } else if selectedTab == 2 {
                    NotificationView()
                } else if selectedTab == 3 {
                    ProfileView()
                } else if selectedTab == 4 {
                    UserHistoryView()
                } else {
                    Text("View not found")
                }
            }
            HStack(spacing: 30) { // Adjust spacing between items
                ForEach(tabbaritems.indices, id: \.self) { index in
                    Button(action: {
                        selectedTab = index
                    }) {
                        VStack(spacing: 4) { // Tight spacing between icon and text
                            Image(systemName: tabbaritems[index].image)
                                .font(.system(size: 20)) // Smaller icon size
                                .foregroundColor(selectedTab == index ? .green : .gray)
                                .scaleEffect(selectedTab == index ? 1.2 : 1.0)
                                .animation(.spring(), value: selectedTab)

                            Text(tabbaritems[index].name)
                                .font(.caption) // Small font size for text
                                .foregroundColor(selectedTab == index ? .green : .gray)
                        }
                    }
                }
            }
            .padding()
            .padding(.vertical, 8) // Adjust padding to make the tab bar compact
            .padding(.horizontal, 10)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)

        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Subview for Main Home Content

struct MainHomeView: View {
    @Binding var region: MKCoordinateRegion
    @Binding var search: String
    @Binding var isActive: Bool
    @State private var isSidebarOpen = false

    var body: some View {
            ZStack {
                // Map view
                Map(coordinateRegion: $region)
                    .cornerRadius(15)
                    .ignoresSafeArea(edges: .all)
                
                ZStack{
                    VStack {
                        // Sidebar toggle button
                        HStack {
                            Button(action: {
                                withAnimation {
                                    isSidebarOpen.toggle()
                                }
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .font(.title)
                                    .padding()
                                    .frame(width: 45, height: 45)
                                    .background(Color.green)
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding()
                    
                    // Sidebar menu
                    if isSidebarOpen {
                        ZStack{
                            Color.black.opacity(0.5)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    withAnimation {
                                        isSidebarOpen.toggle()
                                    }
                                }
                            HStack{
                                SidebarMenu(viewModel: MainViewViewModel(),
                                            isSidebarOpen: $isSidebarOpen)
                                    .frame(width: UIScreen.main.bounds.width * 0.65)
                                    .background(Color.white)
                                    .cornerRadius(70)
                                    .shadow(radius: 5)
                                    .ignoresSafeArea()
                                Spacer()
                            }
                        }
                        .transition(.move(edge: .leading))
                    }
                    // Search field
                    VStack {
                        Spacer()
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            
                            NavigationLink(destination: EnterLocation()) {
                                               Text("Search Destination")
                                                   .frame(width: 260, height: 60)
                                                   .foregroundColor(.black)
                                                   .disableAutocorrection(true)
                                                   .padding(.horizontal, 10)
                            }
                            .buttonStyle(PlainButtonStyle()) // Avoid default button style that might alter appearance
                            .padding()
                        }
                        .padding(10)
                        .frame(height: 60)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(20)
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 2)
                        .padding(.horizontal)
                        .padding(.bottom, 50)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
