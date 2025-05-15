//
//  MapView.swift
//  BusTracker
//
//  Created by Zack Williams on 11-11-2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locationProvider: LocationProvider
    @Namespace var mapScope
    @Binding var vehicles: [Vehicle]
    
    var body: some View {
        Map(position: $locationProvider.position) {
            ForEach(vehicles) { vehicle in
                Marker(
                    "",
                    systemImage: vehicle.vehicleOperator?.mode.image() ?? "bus.fill",
                    coordinate: VehiclePlace(location: vehicle.details.location).location
                )
                .tint(vehicle.vehicleOperator?.primaryColour ?? .primary)
            }
        }
            .onMapCameraChange(frequency: .onEnd) { context in
                locationProvider.position = .region(context.region)
            }
            .mapControls {
                VStack {
                    MapUserLocationButton(scope: mapScope)
                    MapScaleView(scope: mapScope)
                }
            }
    }
}

