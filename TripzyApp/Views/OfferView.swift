import SwiftUI

struct Offers: Identifiable {
    let id = UUID()
    let offer: String
    let festival: String
}

struct OfferView: View {
    let offers = [
        Offers(offer: "15% off", festival: "Black Friday"),
        Offers(offer: "5% off", festival: "Christmas"),
        Offers(offer: "20% off", festival: "Happy New Year"),
        Offers(offer: "5% off", festival: "Sunday"),
        Offers(offer: "15% off", festival: "Holi"),
        Offers(offer: "20% off", festival: "Dusshera"),
        Offers(offer: "15% off", festival: "Diwali")
    ]
    
    var body: some View {
        VStack {
            HStack{
                Text("Offer")
                    .font(.headline)
                    .padding(.horizontal, 40)
                Spacer()
            }
            VStack {
                Spacer()
                ForEach(offers) { index in
                    ScrollView{
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 340, height: 70)
                                .overlay(
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(index.offer)
                                                .foregroundColor(.red)
                                                .font(.headline)
                                            
                                            Text(index.festival)
                                                .foregroundColor(.gray)
                                                .font(.subheadline)
                                        }
                                        Spacer()
                                        Button(action: {
                                            print("Button tapped")
                                        }) {
                                            Text("Collect")
                                                .foregroundColor(.white)
                                                .frame(width: 100, height: 30)
                                                .font(.headline)
                                                .padding(.vertical, 8)
                                                .padding(.horizontal, 16)
                                                .background(Color.green)
                                                .cornerRadius(10)
                                        }
                                    }
                                        .padding(.horizontal, 16)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.green, lineWidth: 1)
                                )
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    OfferView()
}
