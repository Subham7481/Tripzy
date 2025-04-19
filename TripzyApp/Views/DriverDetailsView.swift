//
//  DriverDetailsView.swift
//  TripzyApp
//
//  Created by Subham Patel on 16/04/25.
//

import SwiftUI

struct DriverDetailsView: View {
    let driverDetails: [DriverDetails] = [
        DriverDetails(id: UUID(), name: "Raju Saini", email: "rahu123@gmail.com", phoneNumber: "8977095560", vehicle: "Toyota", rating: 4.9),
        DriverDetails(id: UUID(), name: "Akhilesh Singh", email: "akhil561@gmail.com", phoneNumber: "9877665522", vehicle: "Alto", rating: 4.6),
        DriverDetails(id: UUID(), name: "Ankit Raj", email: "ankit672@gmail.com", phoneNumber: "6202122001", vehicle: "Honda", rating: 4.5),
        DriverDetails(id: UUID(), name: "Arnav Ghosh", email: "ghosh23@gmail.com", phoneNumber: "9631889909", vehicle: "Fortuner", rating: 4.3),
        DriverDetails(id: UUID(), name: "Rajan Roy", email: "royrajan43@gmail.com", phoneNumber: "8967885403", vehicle: "Tata Punch", rating: 4.1)
    ]
    @StateObject var viewModel = DriverDetailsViewModel()
    var body: some View {
        VStack{
            Button("Save"){
                saveAllDrivers()
            }
            .frame(width: 150, height: 50)
            .foregroundColor(Color.white)
            .background(Color.green)
            .cornerRadius(10)
            
            List(viewModel.drivers, id: \.id) { driver in
                VStack(alignment: .leading) {
                    Text(driver.name ?? "No name").font(.headline)
                    Text(driver.vehicle ?? "Not available").foregroundColor(.gray)
                    Text("Rating: \(driver.rating, specifier: "%.1f") ⭐")
                }
            }
             
        }.onAppear{
            viewModel.fetchDrivers()
        }
    }
    func saveAllDrivers(){
        for i in driverDetails{
            CoreDataManager.shared.saveDriver(details: i)
        }
        viewModel.fetchDrivers()
    }
}

#Preview {
    DriverDetailsView()
}

