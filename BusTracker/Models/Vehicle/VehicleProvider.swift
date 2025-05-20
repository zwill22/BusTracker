//
//  VehicleProvider.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

@MainActor
class VehicleProvider: ObservableObject {
    @Published var vehicles: [Vehicle] = []
    @Published var maxVehicles = 500
    @Published var maxTime = 3600
    @Published var timeout = 60
    
    
    let client: VehicleClient
    
    func fetchVehicles(
        mapLocation: MapLocation,
        operators: [Operator]
    ) async throws {
        let nearestVehicles = try await client.vehicles(
            mapLocation: mapLocation,
            maxVehicles: maxVehicles,
            maxTime: maxTime
        )
        
        self.vehicles = nearestVehicles.map({ Vehicle(vehicle: $0, operators: operators) })
    }
    
    func updateVehicle(atOffset: Int) async throws {
        let vehicleRef = vehicles[atOffset].details.vehicleRef
        let updatedVehicle = try await client.vehicle(vehicleRef: vehicleRef)
        self.vehicles[atOffset] = updatedVehicle
    }
    
    func updateVehicles(stops: [Stop]) {
        self.vehicles = self.vehicles.map { Vehicle(vehicle: $0, stops: stops) }
    }
    
    init(client: VehicleClient = VehicleClient()) {
        self.client = client
    }
}
