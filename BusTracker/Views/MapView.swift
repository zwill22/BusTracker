//
//  MapView.swift
//  BusTracker
//
//  Created by Zack Williams on 11-11-2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Namespace var mapScope
    @Binding var position: MapCameraPosition
    @Binding var buses: [Bus]
    
    var body: some View {
        Map(position: $position) {
            ForEach(buses) { bus in
                Marker("", systemImage: "bus", coordinate: bus.details.location.getPlace())
                    .tint(bus.primaryColour)
            }
        }
            .onMapCameraChange(frequency: .onEnd) { context in
                position = .region(context.region)
            }
            .mapControls {
                VStack {
                    MapUserLocationButton(scope: mapScope)
                    MapScaleView(scope: mapScope)
                }
            }
    }
}

