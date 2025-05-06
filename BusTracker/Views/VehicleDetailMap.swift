//
//  VehicleDetailMap.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI
import MapKit

struct VehicleDetailMap: View {
    let location: VehicleLocation
    let tintColour: Color
    private let place: VehiclePlace
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion())
    
    init(vehicle: Vehicle) {
        self.location = vehicle.details.location
        self.tintColour = vehicle.vehicleOperator?.primaryColour ?? .primary.opacity(0.80)
        self.place = VehiclePlace(location: location)
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

struct VehiclePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), location: VehicleLocation) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: location.latitude,
            longitude: location.longitude
        )
        
    }
}


