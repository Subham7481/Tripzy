import SwiftUI
import Firebase

@main
struct TripzyAppApp: App {
    @StateObject private var viewModel = MainViewViewModel()
    let persistenceController = PersistenceController.shared
    init() {
            FirebaseApp.configure()
        }
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
