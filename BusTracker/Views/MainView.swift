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
    @Environment(IssueManager.self) private var issueManager
    
    @State private var error: BusTrackerError?
    @State private var hasError: Bool = false
    
    func checkAPI() async {
        let targetVersion = "0.4.1"
        
        do {
            try await vehicleProvider.fetchAPIVersion()
        } catch {
            self.error = error as? BusTrackerError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        
        if let version = vehicleProvider.apiVersion {
            let equalVersion = version.compare(targetVersion, options: .numeric) == .orderedSame
            let validVersion = version.compare(targetVersion, options: .numeric) == .orderedDescending
            
            if (!(equalVersion || validVersion)) {
                self.error = BusTrackerError.incompatibleOpenBusAPIVersion
                self.hasError = true
            }
        }
    }
    
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
                    vehicleProvider: vehicleProvider,
                    issueManager: issueManager
                )
            }
        }
        .alert(isPresented: $hasError, error: error) {}
        .task {
            await checkAPI()
        }
    }
}

#Preview {
    MainView()
        .environment(LocationProvider())
        .environment(OperatorProvider.preview)
        .environment(StopProvider.preview)
        .environment(VehicleProvider.preview)
        .environment(IssueManager())
}
