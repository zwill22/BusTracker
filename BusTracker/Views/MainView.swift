//
//  MainView.swift
//  BusTracker
//
//  Created by Zack Williams on 05-05-2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var operatorProvider: OperatorProvider
    @EnvironmentObject var vehicleProvider: VehicleProvider
    @EnvironmentObject var locationProvider: LocationProvider
    
    var body: some View {
        TabView {
            Tab("Vehicles", systemImage: "bus") {
                Vehicles()
                    .environmentObject(vehicleProvider)
                    .environmentObject(operatorProvider)
                    .environmentObject(locationProvider)
            }
            
            Tab("Operators", systemImage: "cablecar.fill") {
                Operators().environmentObject(operatorProvider)
            }
        }
    }
}

#Preview {
    MainView().environmentObject(VehicleProvider.preview).environmentObject(OperatorProvider.preview)
        .environmentObject(LocationManager())
}
