//
//  StopMap.swift
//  BusTracker
//
//  Created by Zack Williams on 20-05-2025.
//

import SwiftUI
import MapKit


struct StopMap: View {
    @EnvironmentObject var locationProvider: LocationProvider
    @Namespace var stopMapScope
    @Binding var stops: [Stop]
    
    var body: some View {
        Map(position: $locationProvider.position) {
            ForEach(stops) { stop in
                if let location = stop.location {
                    Marker(
                        "",
                        systemImage: "mappin.circle.fill",
                        coordinate: VehiclePlace(location: location).location
                    )
                    .tint(.red)
                }
            }
        }
        .onAppear {
            locationProvider.position = .automatic
        }
    }
}

