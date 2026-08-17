//
//  VehicleToolbar.swift
//  BusTracker
//
//  Created by Zack Williams on 13-11-2024.
//

import MapKit
import SwiftUI

extension Vehicles {

    @ViewBuilder
    func toolbarStatus() -> some View {
        ToolbarStatus(
            isLoading: vehiclesLoading,
            lastUpdated: vehiclesLastUpdated,
            count: vehicleProvider.vehicles.count,
            itemType: "Vehicles"
        )
    }

    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            RefreshButton(isLoading: $vehiclesLoading) {
                Task {
                    await fetchVehicles()
                }
            }
        }

        ToolbarItem(placement: .title) {
            toolbarStatus()
        }

        ToolbarItem(placement: .topBarTrailing) {
            UserLocationButton(
                isLoading: $locationLoading,
                centredOnUser: $centredOnUser
            ) {
                fetchUserLocation()
            }
        }

    }
}
