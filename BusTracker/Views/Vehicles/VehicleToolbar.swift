//
//  VehicleToolbar.swift
//  BusTracker
//
//  Created by Zack Williams on 13-11-2024.
//

import SwiftUI

extension Vehicles {
    
    @ViewBuilder
    func toolbarStatus() -> some View {
        ToolbarStatus(
            isLoading: isLoading,
            lastUpdated: vehiclesLastUpdated,
            count: vehicleProvider.vehicles.count,
            itemType: "Vehicles"
        )
    }
    
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton(isLoading: $isLoading) {
                Task {
                    await fetchVehicles()
                }
            }
            Spacer()
            toolbarStatus()
            Spacer()
        }
    }
}
