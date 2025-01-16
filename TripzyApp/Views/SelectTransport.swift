import SwiftUI

struct SelectTransport: View {
    
    let transportOptions = [
        ["image": "Car", "name": "Car"],
        ["image": "Bike", "name": "Bike"],
        ["image": "Auto", "name": "Auto"],
        ["image": "CarPremium", "name": "Car Premium"]
    ]
    
    var body: some View {
//        NavigationStack {
            VStack {
                HStack{
                    Text("Select Transport")
                        .font(.headline)
                        .padding(.top, 250)
                    Spacer()
                }.padding()
                
                Text("Select your transport")
                    .font(.title)
                    .padding(.top, 20)
                
                HStack {
                    VStack {
                        ForEach(0..<2) { index in
                            TransportOptionView(transport: transportOptions[index])
                        }
                        .padding()
                    }
                    VStack {
                        ForEach(2..<transportOptions.count) { index in
                            TransportOptionView(transport: transportOptions[index])
                        }
                        .padding()
                    }
                }
                .padding(.bottom, 400)
            }
//        }
    }
}

struct TransportOptionView: View {
    var transport: [String: String]
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .frame(width: 160, height: 170)
                    .foregroundColor(Color.green.opacity(0.5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.green, lineWidth: 2)
                    )
                
                VStack {
                    NavigationLink(destination: BookingView(selectedImage: transport["image"]!)) {
                        Image(transport["image"]!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .cornerRadius(100)
                    }
                    Text(transport["name"]!)
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                }
            }
        }
    }
}

#Preview {
    SelectTransport()
}
