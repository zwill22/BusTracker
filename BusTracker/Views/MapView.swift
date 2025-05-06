//
//  MapView.swift
//  BusTracker
//
//  Created by Zack Williams on 11-11-2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locationManager: LocationManager
    @Namespace var mapScope
    @Binding var vehicles: [Vehicle]
    
    var body: some View {
        Map(position: $locationManager.position) {
            ForEach(vehicles) { vehicle in
                Marker("", systemImage: "bus",
                       coordinate: VehiclePlace(location: vehicle.details.location).location)
                    .tint(vehicle.primaryColour)
            }
        }
            .onMapCameraChange(frequency: .onEnd) { context in
                locationManager.position = .region(context.region)
            }
            .mapControls {
                VStack {
                    MapUserLocationButton(scope: mapScope)
                    MapScaleView(scope: mapScope)
                }
            }
    }
}

