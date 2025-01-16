import SwiftUI

struct UserHistoryView: View {
    @State private var selectedSubButton: Int? = 0
    var body: some View {
        VStack {
            HStack {
                Text("History")
                    .font(.headline)
                    .padding(.horizontal, 20)
                Spacer()
            }
            .padding()
            .padding(.top,10)
                   // Main Button Container with overlay and border
                   Button(action: {
                       // Action for the main button
                       print("Main button tapped")
                   }) {
                       ZStack {
                           HStack(spacing: 0) {
                               subButton(index: 0, title: "Upcoming")
                               subButton(index: 1, title: "Completed")
                               subButton(index: 2, title: "Cancelled")
                           }
                       }
                       .frame(width: 360, height: 50)
                       .background(Color.green.opacity(0.2)) // Green overlay
                       .cornerRadius(10)
                       .overlay(
                           RoundedRectangle(cornerRadius: 10)
                               .stroke(Color.green, lineWidth: 1) // Green border
                       )
                   }
                   .buttonStyle(PlainButtonStyle())
                   .padding(.top, 10)
               }
                .padding(.bottom, 600)
           }
           
           // Sub-button view
           private func subButton(index: Int, title: String) -> some View {
               Button(action: {
                   selectedSubButton = index
               }) {
                   Text(title)
                       .font(.subheadline)
                       .foregroundColor(selectedSubButton == index ? .white : .black)
                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                       .padding(1)
                       .background(selectedSubButton == index ? Color.green : Color.white)
                       .cornerRadius(0)
               }
               .buttonStyle(PlainButtonStyle())
           }
}

#Preview {
    UserHistoryView()
}
