//
//  VehicleClient.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import XMLCoder

func distance(vehicle: Vehicle, userLongitude: Double, userLatitude: Double) -> Double {
    let vehicleLongitude = vehicle.details.location.longitude
    let vehicleLatitude = vehicle.details.location.latitude
    
    let deltaLongitude = vehicleLongitude - vehicleLongitude
    let deltaLatitude = vehicleLatitude - vehicleLatitude
    
    return sqrt(pow(deltaLongitude, 2) + pow(deltaLatitude, 2))
}

actor VehicleClient {
    
    func vehicles(
        minLongitude: Double, minLatitude: Double,
        maxLongitude: Double, maxLatitude: Double,
        userLongitude: Double, userLatitude: Double
    ) async throws -> [Vehicle] {
        let feedURL: URL = getFeedURL(minLongitude: minLongitude, minLatitude: minLatitude, maxLongitude: maxLongitude, maxLatitude: maxLatitude)
        guard let data = try? await downloader.httpData(from: feedURL) else {
            throw VehicleError.networkError
        }
        let allVehicles = try decoder.decode(XML.self, from: data)
        
        // Only return recent buses if
        if (allVehicles.vehicles.count < 500) {
            return allVehicles.vehicles
        }
        
        var filteredVehicles: [Vehicle] = allVehicles.vehicles.filter({ $0.time.timeIntervalSinceNow > -3600})
        
        filteredVehicles.sort {
            distance(vehicle: $0, userLongitude: userLongitude, userLatitude: userLatitude) < distance(vehicle: $1, userLongitude: userLongitude, userLatitude: userLatitude)
        }
        
        
        
        if (filteredVehicles.count > 500) {
            return Array(filteredVehicles[0..<500])
        }
        
        return filteredVehicles
    }
    
    func vehicle(vehicleRef: String) async throws -> Vehicle {
        let feedURL:URL = getFeedURL(vehicleRef: vehicleRef)
        let data = try await downloader.httpData(from: feedURL)
        let vehicleData = try decoder.decode(XML.self, from: data)
        
        if (vehicleData.vehicles.count != 1) {
            throw VehicleError.networkError
        }
        
        return vehicleData.vehicles[0]
    }

    private lazy var decoder: XMLDecoder = {
        let aDecoder = XMLDecoder()
        aDecoder.dateDecodingStrategy = .iso8601
        return aDecoder
    }()
    

    private func getFeedURL(minLongitude: Double, minLatitude: Double, maxLongitude: Double, maxLatitude: Double
        
    ) -> URL {
        let urlRoot = "http://localhost:5134/location/area/"
        
        let result = urlRoot + minLatitude.description + "/" + minLongitude.description + "/" + maxLatitude.description + "/" + maxLongitude.description
        
        return URL(string: result)!
    }
    
    private func getFeedURL(vehicleRef: String) -> URL {
        let urlRoot = "http://localhost:5134/vehicle/"
        
        let result = urlRoot + vehicleRef
        
        return URL(string: result)!
    }
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
