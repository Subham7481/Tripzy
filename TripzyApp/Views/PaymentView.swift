import SwiftUI
import CoreData

struct PaymentView: View {
    @State private var showContent = false
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            HStack {
                Text("Confirm Ride")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .padding()

            if showContent {
                VStack {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: [.blue, .purple, .green], startPoint: .top, endPoint: .bottom))
                            .frame(width: 140, height: 140)
                        Image("Tick")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                            .cornerRadius(100)
                    }
                    Text("Thank you")
                        .bold()
                        .font(.title)
                    Text("Your booking has been placed!")
                    Spacer()
                }
            }

            Spacer()

            Button(action: {
//                saveRide(pickup: "Location A", dropoff: "Location B", fare: 10.0, status: "Confirmed")
                showContent = true
            }) {
                Text("Confirm Ride")
                    .frame(width: 330, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    PaymentView()
}
