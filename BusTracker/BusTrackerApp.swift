//
//  BusTrackerApp.swift
//  BusTracker
//
//  Created by Zack Williams on 08-11-2024.
//

import SwiftUI

@main
struct BusTrackerApp: App {
    @StateObject var vehicleProvider = VehicleProvider()
    @StateObject var operatorProvider = OperatorProvider()
    @StateObject var locationProvider = LocationProvider()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vehicleProvider)
                .environmentObject(operatorProvider)
                .environmentObject(locationProvider)
        }
    }
}
