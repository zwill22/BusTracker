//
//  BusTrackerApp.swift
//  BusTracker
//
//  Created by Zack Williams on 08-11-2024.
//

import SwiftUI

@main
struct BusTrackerApp: App {
    @StateObject var busProvider = BusProvider()
    @StateObject var operatorProvider = OperatorProvider()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(busProvider)
                .environmentObject(operatorProvider)
        }
    }
}
