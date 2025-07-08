//
//  VehicleToolbar.swift
//  BusTracker
//
//  Created by Zack Williams on 13-11-2024.
//

import SwiftUI

extension Vehicles {
    
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            if isLoading {
                ProgressView()
            } else {
                RefreshButton {
                    Task {
                        await fetchVehicles()
                    }
                }
            }
            
            Spacer()
            ToolbarStatus(
                isLoading: isLoading,
                lastUpdated: vehiclesLastUpdated,
                vehicleCount: vehicleProvider.vehicles.count
            )
            Spacer()
        }
    }
}
