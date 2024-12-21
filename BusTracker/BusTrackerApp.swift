//
//  BusTrackerApp.swift
//  BusTracker
//
//  Created by Zack Williams on 08-11-2024.
//

import SwiftUI

@main
struct BusTrackerApp: App {
    @StateObject private var authenticationStore = AuthenticationStore()
    @StateObject var busProvider = BusProvider()
    var body: some Scene {
        WindowGroup {
            Buses(authentication: $authenticationStore.authentication) {
                Task {
                    do {
                        try await authenticationStore.save(authentication: authenticationStore.authentication)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await authenticationStore.load()
                    }
                    catch {
                        fatalError(error.localizedDescription)
                    }
                }
                .environmentObject(busProvider)
        }
    }
}
