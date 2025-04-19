//
//  DriverDetailsViewModel.swift
//  TripzyApp
//
//  Created by Subham Patel on 16/04/25.
//

import Foundation
class DriverDetailsViewModel: ObservableObject{
    @Published var drivers: [DriverEntity] = []
    
    init(){
        fetchDrivers()
    }
    
    func fetchDrivers(){
        drivers = CoreDataManager.shared.fetchDrivers()
    }
}
