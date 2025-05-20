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
    private let height = CGFloat(24)
    private let place: VehiclePlace
    private let destinationPlace: VehiclePlace?
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion())
    
    
    init(vehicle: Vehicle, destination: Stop?) {
        self.location = vehicle.details.location
        self.tintColour = vehicle.vehicleOperator?.primaryColour ?? .primary.opacity(0.80)
        self.place = VehiclePlace(location: location)

        if let destinationLocation = destination?.location {
            self.destinationPlace = VehiclePlace(location: destinationLocation)
        } else {
            self.destinationPlace = nil
        }
    }
    
    var body: some View {
        Map(position: $position) {
            Marker("", systemImage: "bus", coordinate: place.location)
                .tint(tintColour)

            if let location = destinationPlace?.location {
                Annotation("", coordinate: location) {
                    ZStack {
                        Circle().fill(.red).frame(width: height, height: height)
                        Image(systemName: "xmark.circle").resizable().frame(width: height, height: height)
                    }
                }
            }
        }
            .onAppear {
                withAnimation {
                    position = .automatic
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


