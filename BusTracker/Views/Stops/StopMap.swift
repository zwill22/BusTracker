//
//  StopMap.swift
//  BusTracker
//
//  Created by Zack Williams on 20-05-2025.
//

import SwiftUI
import MapKit


struct StopMap: View {
    @Namespace var stopMapScope
    
    @Binding var position: MapCameraPosition
    @Binding var stops : [Stop]
    @State var height = CGFloat(24)
    
    var body: some View {
        Map(position: $position) {
            ForEach(stops) { stop in
                if let location = stop.location {
                    Annotation("", coordinate: VehiclePlace(location: location).location) {
                        stop.stopType.view()
                    }
                }
            }
        }
        .onAppear {
            position = .automatic
        }
    }
}

