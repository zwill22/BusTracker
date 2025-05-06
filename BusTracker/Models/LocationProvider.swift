//
//  LocationProvider.swift
//  BusTracker
//
//  Created by Zack Williams on 06-05-2025.
//

import Foundation
import MapKit
import SwiftUI

struct MapLocation {
    var centreLongitude: Double
    var centreLatitude: Double
    var longitudeDelta: Double
    var latitudeDelta: Double
}

@MainActor
class LocationProvider: ObservableObject {
    private let locationManager: LocationManager
    
    @Published var defaultDelta = 0.1
    @Published var maxDelta = 1.0
    @Published var position : MapCameraPosition = .automatic
    
    func getLocation() -> CLLocation? {
        return locationManager.location
    }
    
    func updatePosition() {
        if let location = locationManager.location {
            position = MapCameraPosition.region(MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: defaultDelta, longitudeDelta: defaultDelta)
            ))
        }
    }
    
    
    func mapLocation() -> MapLocation? {
        guard let region = position.region else { return nil }
        
        let deltaLatitude = min(region.span.latitudeDelta, maxDelta) / 2
        let deltaLongitude = min(region.span.longitudeDelta, maxDelta) / 2
        
        return MapLocation(
            centreLongitude: region.center.longitude,
            centreLatitude: region.center.latitude,
            longitudeDelta: deltaLongitude,
            latitudeDelta: deltaLatitude
        )
    }
    
    init() {
        self.locationManager = LocationManager()
        updatePosition()
    }
}
