//
//  Settings.swift
//  BusTracker
//
//  Created by Zack Williams on 28-05-2025.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var vehicleProvider: VehicleProvider
    @EnvironmentObject var operatorProvider: OperatorProvider
    @EnvironmentObject var stopProvider: StopProvider
    @EnvironmentObject var locationProvider: LocationProvider
    
    var body: some View {
        VStack {
            SettingsBlock(height: 80).padding(.top)
            Text("Settings").font(.title).padding(.bottom)
            Form {
                Section(header: Text("Vehicle Options")) {
                    VehicleSettings(
                        maxVehicles: $vehicleProvider.maxVehicles,
                        maxTime: $vehicleProvider.maxTime,
                        timeout: $vehicleProvider.timeout
                    )
                }
                Section(header: Text("Operator settings")) {
                    OperatorSettings(operators: $operatorProvider.vehicleOperators)
                }
                
                Section(header: Text("Stop settings")) {
                    StopSettings(maxStops: $stopProvider.maxStops)
                }
                
                Section(header: Text("Location settings")) {
                    LocationSettings(
                        defaultDelta: $locationProvider.defaultDelta,
                        maxDelta: $locationProvider.maxDelta
                    )
                }
                
                Section(header: Text("Additional information")) {
                    BaseLink(
                        label: "GitHub Repository",
                        urlString: "https://github.com/zwill22/BusTracker",
                        image: Image(uiImage: .githubLogo).renderingMode(.template)
                    )
                    Text("Support my work:")
                    HStack {
                        Spacer()
                        BuyMeButton().frame(height: 60)
                        Spacer()
                    }
                }
            }
        }
    }

}

#Preview {
    Settings()
        .environmentObject(VehicleProvider.preview)
        .environmentObject(OperatorProvider.preview)
        .environmentObject(StopProvider.preview)
        .environmentObject(LocationProvider())
}
