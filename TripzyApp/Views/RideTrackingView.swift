//
//  RideTrackingView.swift
//  TripzyApp
//
//  Created by Subham Patel on 16/04/25.
//

import SwiftUI
import MapKit
import CoreLocation
struct RideTrackingView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090), // Default: Delhi
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .onReceive(locationManager.$location) { location in
                if let location = location {
                    region.center = location
                }
            }
            .ignoresSafeArea(.all)
            .frame(maxHeight: 650)
        Spacer()
        
        HStack{
            NavigationLink(destination: HomeView()){
                Text("Go Home")
                    .frame(width: 160, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding()
            }
            //See Details Button
            
            NavigationLink(destination: UserHistoryView()){
                Text("See Details")
                .frame(width: 160, height: 50)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding()
            }
        }
    }
}

#Preview {
    RideTrackingView()
}
