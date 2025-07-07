//
//  MainView.swift
//  BusTracker
//
//  Created by Zack Williams on 05-05-2025.
//

import SwiftUI

struct MainView: View {
    @Environment(LocationProvider.self) private var locationProvider
    @Environment(OperatorProvider.self) private var operatorProvider
    @Environment(StopProvider.self) private var stopProvider
    @Environment(VehicleProvider.self) private var vehicleProvider
    
    var body: some View {
        TabView {
            Tab("Vehicles", systemImage: "bus") {
                Vehicles(
                    locationProvider: locationProvider,
                    operatorProvider: operatorProvider,
                    stopProvider: stopProvider,
                    vehicleProvider: vehicleProvider
                )
            }
            
            Tab("Operators", systemImage: "cablecar.fill") {
                Operators(provider: operatorProvider)
            }
            
            Tab("Stops", systemImage: "mappin.circle.fill") {
                Stops(
                    locationProvider: locationProvider,
                    stopProvider: stopProvider
                )
            }
            Tab("Settings", systemImage: "gear") {
                Settings(
                    locationProvider: locationProvider,
                    operatorProvider: operatorProvider,
                    stopProvider: stopProvider,
                    vehicleProvider: vehicleProvider
                )
            }
        }
    }
}

#Preview {
    MainView()
        .environment(LocationProvider())
        .environment(OperatorProvider.preview)
        .environment(StopProvider.preview)
        .environment(VehicleProvider.preview)
}
