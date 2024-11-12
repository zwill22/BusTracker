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
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $position, scope: mapScope)
            .mapControls {
                VStack {
                    MapUserLocationButton(scope: mapScope)
                    MapScaleView(scope: mapScope)
                }
            }
    }
}


#Preview {
    MapView()
}
