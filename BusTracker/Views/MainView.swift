//
//  MainView.swift
//  BusTracker
//
//  Created by Zack Williams on 05-05-2025.
//

import SwiftUI

struct MainView: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var operatorProvider: OperatorProvider
    @EnvironmentObject var busProvider: BusProvider
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        TabView {
            Tab("Buses", systemImage: "bus") {
                Buses().environmentObject(busProvider).environmentObject(locationManager)
            }
            
            Tab("Operators", systemImage: "cablecar.fill") {
                Operators().environmentObject(operatorProvider)
            }
        }
    }
}

#Preview {
    MainView().environmentObject(BusProvider.preview).environmentObject(OperatorProvider.preview)
}
