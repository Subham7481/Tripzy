import SwiftUI

struct PaymentView: View {
    @State private var showContent = false
    var body: some View {
        HStack{
            Text("Confirm Ride")
                .font(.headline)
                .padding(.top, 10)
                .padding()
            Spacer()
        }.padding()
        if showContent{
            VStack{
                ZStack{
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
            showContent.toggle()
        }, label: {
            Text(showContent ? "Confirm Ride" : "Confirm Ride" )
                .frame(width: 330, height: 50)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding()
        })
        .padding()
    }
}

#Preview {
    PaymentView()
}
