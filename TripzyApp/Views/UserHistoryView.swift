import SwiftUI
import CoreData

struct UserHistoryView: View {
    @StateObject var viewModel: UserHistoryViewViewModel
    @State private var selectedSubButton: Int? = 0
    @Environment(\.managedObjectContext) private var viewContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
           _viewModel = StateObject(wrappedValue: UserHistoryViewViewModel(context: context))
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("History")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            .padding(.top, 20)

            ZStack {
                HStack(spacing: 0) {
                    subButton(index: 0, title: "Upcoming")
                    subButton(index: 1, title: "Completed")
                    subButton(index: 2, title: "Cancelled")
                }
            }
            .frame(width: 360, height: 50)
            .background(Color.green.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green, lineWidth: 1)
            )
            .padding(.top, 10)

            List {
                switch selectedSubButton {
                case 0:
                    ForEach(viewModel.upcomingRides, id: \.self) { ride in
                        BookingRowView(booking: ride)
                    }
                
                case 1:
                    ForEach(viewModel.completedRides, id: \.self) { ride in
                        BookingRowView(booking: ride)
                    }
                    
                case 2:
                    Text("No Cancelled Ride.")
                    
                default:
                    EmptyView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.async{
                viewModel.fetchDrivers()
                viewModel.fetchRideDetails()
                //            viewModel.assignRandomDrivers()
            }
        }
        .padding(.bottom, 600)
    }

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
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct BookingRowView: View {
    let booking: BookingEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Booking ID: \(booking.id?.uuidString ?? "N/A")")
            Text("Date: \(formattedDate(booking.timeStamp))")
            Text("Driver: \(booking.driverName ?? "Not assigned")")
        }
        .padding(5)
    }

    func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "No date" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    UserHistoryView(context: CoreDataManager.shared.context)
        .environment(\.managedObjectContext, CoreDataManager.shared.context)
}
