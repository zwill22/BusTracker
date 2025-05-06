//
//  LocationManager.swift
//  BusTracker
//
//  Created by Zack Williams on 07-04-2025.
//

import MapKit
import SwiftUI

struct MapLocation {
    var centreLongitude: Double
    var centreLatitude: Double
    var longitudeDelta: Double
    var latitudeDelta: Double
}

final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var location : CLLocation?
    @Published var defaultDelta = 0.1
    @Published var maxDelta = 1.0
    @Published var position : MapCameraPosition = .automatic
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.setup()
    }
    
    func setup() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
        
        updatePosition()
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
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        locations.last.map {
            location = $0
        }
        
    }
}
