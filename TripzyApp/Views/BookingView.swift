import SwiftUI

struct BookingView: View {
    var selectedImage: String
    @State var isPressed: Bool = false
    @State var isSelected: Bool = false
//    @Binding var fromLocation: String
//    @Binding var toLocation: String
    let paymentMethods = [
            (name: "UPI", image: "UPI"),
            (name: "Credit Card", image: "Ccard"),
            (name: "PayPal", image: "Paypal"),
            (name: "Net Banking", image: "Cash")
        ]
    
    var body: some View {
        VStack {
            Text("You selected:")
                .font(.title)
                .padding()
            
            //            Text("From: \(fromLocation)")
            //                            .font(.headline)
            //                            .padding()
            //
            //            Text("To: \(toLocation)")
            //                            .font(.headline)
            //                            .padding()
            
            Spacer()
            
            //Payment method
//            NavigationStack{
                VStack{
                    Image(selectedImage)
                        .resizable()
                        .frame(width: 160, height: 160)
                        .padding()
                    
                    Spacer()
                    Text("Select payment method")
                        .font(.title2)
                    ForEach(paymentMethods, id: \.name){ method in
                        NavigationLink(destination: PaymentView()){
                            ZStack{
                                Rectangle()
                                    .frame(width: 360, height: 60)
                                    .foregroundColor(isSelected ? Color.green.opacity(0.4) : Color.green.opacity(0.2))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.green, lineWidth: 1)
                                    )
                                HStack{
                                    Image(method.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(10)
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                    Spacer()
                                }
                                .padding(.horizontal, 30)
                                Text(method.name)
                                    .bold()
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                            }
                        }
                    }
                    Spacer()
                }
//            }
        }
    }
}

#Preview {
    BookingView(selectedImage: "selectedImage")
}
