import SwiftUI
import CoreData

struct ConfirmRideView: View {
    @State private var showContent = false
    @State private var navigateToRideTracking: Bool = false
    @Environment(\.managedObjectContext) private var context
    @StateObject var viewModel = EnterLocationViewViewModel()
    var body: some View {
        VStack {
            HStack{
                HStack {
                    Text("Confirm Ride")
                        .font(.headline)
                        .padding()
                    Spacer()
                }
                .padding()
                
                HStack{
                    NavigationLink(destination: HomeView()){
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.blue)
                    }
                }
            }.padding()
                
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

            Button("Confirm Ride") {
                viewModel.saveToCoreData(context: context)
                showContent = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    navigateToRideTracking = true
                }
            }
            .frame(width: 330, height: 50)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding()
            
            NavigationLink(destination: HomeView(), isActive: $navigateToRideTracking) {
                EmptyView()
            }
//            Button(action: {
//                showContent = true
//
//            }) {
//                Text("Confirm Ride")
//                    .frame(width: 330, height: 50)
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(12)
//                    .padding()
//            }
            .padding()
        }
        .animation(.easeOut, value: showContent)
    }
}

#Preview {
    ConfirmRideView()
}
