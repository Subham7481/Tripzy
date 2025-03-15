import SwiftUI

struct NotificationView: View {
    @State private var showWelcomeMessage = true

    var body: some View {
        ZStack {
            // Main content or welcome message
            if showWelcomeMessage {
                welcomeMessage
            } else {
                mainContent
            }
            VStack {
                HStack {
                    Text("Notifications")
                        .font(.headline)
                        .padding()
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // Automatically dismiss welcome message after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    showWelcomeMessage = false
                }
            }
        }
    }

    // The Welcome Message view
    var welcomeMessage: some View {
        VStack {
            Text("Welcome to the Tripzy!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Button(action: {
                withAnimation {
                    showWelcomeMessage = false
                }
            }) {
                Text("Got It!")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.9))
        .edgesIgnoringSafeArea(.all)
    }

    // The Main Content view
    var mainContent: some View {
        VStack {
            Text("Here are your notifications.")
                .font(.title)
                .padding()
            // Add the rest of your notification content here
        }
    }
}

#Preview {
    NotificationView()
}
