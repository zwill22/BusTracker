//
//  VehicleDetailMap.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI
import MapKit

struct VehicleDetailMap: View {
    @Binding var vehicle: Vehicle
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion())
    
    func getPlace() -> VehiclePlace {
        return VehiclePlace(location: vehicle.details.location)
    }
    
    func getDestinationLocation() -> CLLocationCoordinate2D? {
        if let destinationLocation = vehicle.destination?.location {
            return VehiclePlace(location: destinationLocation).location
        }
        
        return nil
    }
    
    func updatePosition(latitudeScale: CGFloat = 2.0, longitudeScale: CGFloat = 1.2) -> MapCameraPosition {
        let place = getPlace()
        
        if let destinationLocation = getDestinationLocation() {
            let sumLatitude = place.location.latitude + destinationLocation.latitude
            let sumLongitude = place.location.longitude + destinationLocation.longitude
            let centre = CLLocationCoordinate2D(latitude: sumLatitude / 2, longitude: sumLongitude / 2)
            
            let deltaLatitude = max(abs(place.location.latitude - destinationLocation.latitude), 0.001)
            let deltaLongitude = max(abs(place.location.longitude - destinationLocation.longitude), 0.001)
            
            let span  = MKCoordinateSpan(
                latitudeDelta: latitudeScale * deltaLatitude,
                longitudeDelta: longitudeScale * deltaLongitude
            )
            
            return .region(.init(center: centre, span: span))
        }
        
        return .automatic
    }
    
    var body: some View {
        let place = getPlace()
        let tintColour = vehicle.vehicleOperator? .primaryColour ?? .primary.opacity(0.80)
        let destinationBusType = vehicle.destination?.busStopType ?? .none
        let destinationType = vehicle.destination?.stopType ?? .none
        
        Map(position: $position) {
            Marker("", systemImage: "bus", coordinate: place.location)
                .tint(tintColour)
            
            if let location = getDestinationLocation() {
                if let busStopView = destinationBusType?.view(height: 24) {
                    Annotation("", coordinate: location) {
                        busStopView
                    }
                } else if let view = destinationType?.view(height: 24) {
                    Annotation("", coordinate: location) {
                        view
                    }
                }
            }
        }
        .onChange(of: vehicle.details.location, initial: true) {
            withAnimation {
                position = updatePosition()
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


