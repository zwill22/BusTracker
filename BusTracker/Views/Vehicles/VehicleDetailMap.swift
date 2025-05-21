//
//  VehicleDetailMap.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI
import MapKit

struct VehicleDetailMap: View {
    private let location: VehicleLocation
    private let tintColour: Color
    private let height = CGFloat(24)
    private let place: VehiclePlace
    private let destinationPlace: VehiclePlace?
    private let destinationType: StopType?
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion())
    
    
    init(vehicle: Vehicle, destination: Stop?) {
        self.location = vehicle.details.location
        self.tintColour = vehicle.vehicleOperator?.primaryColour ?? .primary.opacity(0.80)
        self.place = VehiclePlace(location: location)

        if let destinationLocation = destination?.location {
            self.destinationPlace = VehiclePlace(location: destinationLocation)
            self.destinationType = destination?.stopType
        } else {
            self.destinationPlace = nil
            self.destinationType = nil
        }
    }
    
    func updatePosition(latitudeScale: CGFloat = 2.0, longitudeScale: CGFloat = 1.2) -> MapCameraPosition {
        if let destinationLocation = destinationPlace?.location {
            let sumLatitude = place.location.latitude + destinationLocation.latitude
            let sumLongitude = place.location.longitude + destinationLocation.longitude
            let centre = CLLocationCoordinate2D(latitude: sumLatitude / 2, longitude: sumLongitude / 2)
            
            let deltaLatitude = max(abs(place.location.latitude - destinationLocation.latitude), 0.001)
            let deltaLongitude = max(abs(place.location.longitude - destinationLocation.longitude), 0.001)
            print("Longitude: \(deltaLongitude)")
            print("Latitude: \(deltaLatitude)")
            
            let span  = MKCoordinateSpan(
                latitudeDelta: latitudeScale * deltaLatitude,
                longitudeDelta: longitudeScale * deltaLongitude
            )
            
            return .region(.init(center: centre, span: span))
        }
        
        return .automatic
    }
    
    var body: some View {
        Map(position: $position) {
            Marker("", systemImage: "bus", coordinate: place.location)
                .tint(tintColour)
            
            if let location = destinationPlace?.location {
                if let view = destinationType?.view() {
                    Annotation("", coordinate: location) {
                        view
                    }
                }
            }
        }
            .onAppear {
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


