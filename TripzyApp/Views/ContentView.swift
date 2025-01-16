import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoggedIn {
                HomeView(viewModel: viewModel)
            } else {
                MainView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.checkAuthentication()
        }
    }
}

#Preview {
    ContentView()
}
