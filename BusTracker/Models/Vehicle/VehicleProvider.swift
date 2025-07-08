//
//  VehicleProvider.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

@MainActor
@Observable
class VehicleProvider {
    var vehicles: [Vehicle] = []
    var maxVehicles: Int = 500
    var maxTime: Int = 3600
    var timeout: Int = 60
    var refreshInterval: Int = 30
    
    let client: VehicleClient
    
    func fetchVehicles(mapLocation: MapLocation) async throws {
        self.vehicles = try await client.vehicles(
            mapLocation: mapLocation,
            maxVehicles: maxVehicles,
            maxTime: maxTime
        )
    }
    
    func getOperators(_ offset: Int) -> [Operator] {
        if let vehicleOperator = self.vehicles[offset].vehicleOperator {
            return [vehicleOperator]
        }
        
        return []
    }
    
    func getStops(_ offset: Int) -> [Stop] {
        return self.vehicles[offset].getStops()
    }
    
    func updateVehicle(atOffset: Int) async throws {
        let vehicleRef = vehicles[atOffset].details.vehicleRef
        let updatedVehicle = try await client.vehicle(vehicleRef: vehicleRef)
        let operators = getOperators(atOffset)
        let stops:[Stop] = getStops(atOffset)
        
        self.vehicles[atOffset] = Vehicle(vehicle: updatedVehicle, operators: operators, stops: stops)
    }
    
    
    func updateVehicles(operators: [Operator], stops: [Stop]) {
        self.vehicles = self.vehicles.map {
            Vehicle(vehicle: $0, operators: operators, stops: stops)
        }
    }
    
    init(client: VehicleClient = VehicleClient()) {
        self.client = client
    }
}
