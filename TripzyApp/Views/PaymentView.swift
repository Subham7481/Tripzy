import SwiftUI

struct PaymentView: View {
    @EnvironmentObject var viewModel : EnterLocationViewViewModel
    @State var selectedImage: String = "Car"
    @State var isPressed: Bool = false
    @State var isSelected: Bool = false
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
            
//            HStack{
//                Text("From: \(viewModel.startLocation)")
//                    .font(.headline)
//                    .padding()
//                Spacer()
//            }.padding(.horizontal)
//
//            HStack{
//                Text("To: \(viewModel.endLocation)")
//                    .font(.headline)
//                    .padding()
//                Spacer()
//            }.padding(.horizontal)
            
            //Payment method
//            NavigationStack{
                VStack{
                    Image(selectedImage)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding()
                    //Payable Ammount and apply offer button
                    HStack{
                        Text("Pay ₹ \(viewModel.fareAmount ?? 0.0)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(width: 165, height: 50)
                            .background(Color.green.opacity(0.6))
                            .cornerRadius(10)
                        
                        Spacer()
                        
                        NavigationLink(destination: OfferView()){
                            Text("Apply Offer")
                                .font(.system(size: 15, weight: .bold))
                                .frame(width: 165, height: 50)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }.padding(.horizontal, 25)
                    
                    Text("Select payment method")
                        .font(.title2)
//                        .padding()
                    ForEach(paymentMethods, id: \.name){ method in
                        NavigationLink(destination: ConfirmRideView().environmentObject(viewModel)){
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
    PaymentView()
        .environmentObject(EnterLocationViewViewModel())
}
