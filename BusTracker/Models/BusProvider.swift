//
//  BusProvider.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import SwiftUI
import MapKit

@MainActor
class BusProvider: ObservableObject {
    @Published var buses: [Bus] = []
    
    let client: BusClient
    let maxDelta: Double = 1
    
    func fetchBuses(
        position: MapCameraPosition,
        userLocation: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
    ) async throws {
        if (position.region == nil) {
            throw BusError.dataFormatError
        }
        
        let region = position.region!
        
        let deltaLatitude = min(region.span.latitudeDelta, maxDelta) / 2
        let deltaLongitude = min(region.span.longitudeDelta, maxDelta) / 2
        
        let minLongitude = region.center.longitude - deltaLongitude
        let minLatitude = region.center.latitude - deltaLatitude
        let maxLongitude = region.center.longitude + deltaLongitude
        let maxLatitude = region.center.latitude + deltaLatitude

        
        let nearestBuses = try await client.buses(
            minLongitude: minLongitude, minLatitude: minLatitude,
            maxLongitude: maxLongitude, maxLatitude: maxLatitude,
            userLongitude: userLocation.longitude, userLatitude: userLocation.latitude);
        self.buses = nearestBuses
    }
    
    func updateBus(atOffset: Int) async throws {
        let vehicleRef = buses[atOffset].details.vehicleRef
        let updatedBus = try await client.bus(vehicleRef: vehicleRef)
        self.buses[atOffset] = updatedBus
    }
    
    func deleteBuses(atOffsets offsets: IndexSet) {
        buses.remove(atOffsets: offsets)
    }
    
    init(client: BusClient = BusClient()) {
        self.client = client
    }
}
