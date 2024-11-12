//
//  BusDetailMap.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI
import MapKit

struct BusDetailMap: View {
    let location: BusLocation
    let tintColour: Color
    private let place: BusPlace
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion())
    
    init(location: BusLocation, tintColour: Color) {
        self.location = location
        self.tintColour = tintColour
        self.place = BusPlace(location: location)
    }
    
    var body: some View {
        Map(position: $position) {
            Marker("", systemImage: "bus", coordinate: place.location)
                .tint(tintColour)
        }
            .onAppear {
                withAnimation {
                    position = .region(MKCoordinateRegion(center: place.location, span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)))
                }
            }
    }
}

struct BusPlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), location: BusLocation) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
    }
}


