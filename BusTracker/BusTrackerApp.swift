//
//  BusTrackerApp.swift
//  BusTracker
//
//  Created by Zack Williams on 08-11-2024.
//

import SwiftUI

@main
struct BusTrackerApp: App {
    @State var locationProvider = LocationProvider()
    @State var operatorProvider = OperatorProvider()
    @State var stopProvider = StopProvider()
    @State var vehicleProvider = VehicleProvider()
    @State var issueManager = IssueManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(locationProvider)
                .environment(operatorProvider)
                .environment(stopProvider)
                .environment(vehicleProvider)
                .environment(issueManager)
        }
    }
}
