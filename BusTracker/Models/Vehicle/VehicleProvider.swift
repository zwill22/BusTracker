//
//  VehicleProvider.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import SwiftUI
import MapKit

@MainActor
class VehicleProvider: ObservableObject {
    @Published var vehicles: [Vehicle] = []
    
    let client: VehicleClient
    let maxDelta: Double = 1
    
    func fetchVehicles(
        position: MapCameraPosition,
        userLocation: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
    ) async throws {
        if (position.region == nil) {
            throw VehicleError.dataFormatError
        }
        
        let region = position.region!
        
        let deltaLatitude = min(region.span.latitudeDelta, maxDelta) / 2
        let deltaLongitude = min(region.span.longitudeDelta, maxDelta) / 2
        
        let minLongitude = region.center.longitude - deltaLongitude
        let minLatitude = region.center.latitude - deltaLatitude
        let maxLongitude = region.center.longitude + deltaLongitude
        let maxLatitude = region.center.latitude + deltaLatitude

        
        let nearestVehicles = try await client.vehicles(
            minLongitude: minLongitude, minLatitude: minLatitude,
            maxLongitude: maxLongitude, maxLatitude: maxLatitude,
            userLongitude: userLocation.longitude, userLatitude: userLocation.latitude);
        self.vehicles = nearestVehicles
    }
    
    func updateVehicle(atOffset: Int) async throws {
        let vehicleRef = vehicles[atOffset].details.vehicleRef
        let updatedVehicle = try await client.vehicle(vehicleRef: vehicleRef)
        self.vehicles[atOffset] = updatedVehicle
    }
    
    func deleteVehicles(atOffsets offsets: IndexSet) {
        vehicles.remove(atOffsets: offsets)
    }
    
    init(client: VehicleClient = VehicleClient()) {
        self.client = client
    }
}
