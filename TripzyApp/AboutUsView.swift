import SwiftUI

struct AboutUsView: View {
    var message: [String] = [
        "Welcome to TripzyApp, the future of seamless and affordable ride-sharing. We are dedicated to connecting riders and drivers efficiently, prioritizing safety, reliability, and comfort. Our mission is to make every journey stress-free and eco-friendly by promoting carpooling and reducing carbon footprints. With user-friendly features, real-time tracking, and transparent pricing, we empower our community to travel smarter. Whether you're commuting to work, heading to the airport, or exploring new destinations, TripzyApp ensures a ride that suits your needs. Join us in revolutionizing urban mobility—because every trip matters, and so does your experience. Let’s ride together!"
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("About Us")
                    .font(.headline)
                    .padding(.horizontal, 20)
                Spacer()
            }
            .padding(.bottom, 30)

            // ScrollView for message
            ScrollView {
                           VStack {
                               ForEach(message, id: \.self) { showMessage in
                                   HStack {
                                       Text(showMessage)
                                           .font(.body)
                                           .multilineTextAlignment(.center)
                                           .lineLimit(nil)
                                           .padding(.horizontal, 20)
                                   }
                               }
                           }
                       }
                       .padding(.top, 10)
                   }
                   .padding(.top)
    }
}

#Preview {
    AboutUsView()
}
