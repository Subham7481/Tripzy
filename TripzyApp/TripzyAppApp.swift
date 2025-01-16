import SwiftUI
import Firebase

@main
struct TripzyAppApp: App {
    @StateObject private var viewModel = MainViewViewModel()
    init() {
            FirebaseApp.configure()
        }
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
