//
//  VehicleClient.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import XMLCoder


func distance(latitude: Double, longitude: Double, centreLatitude: Double, centreLongitude: Double) -> Double {
    
    
    let deltaLongitude = longitude - centreLongitude
    let deltaLatitude = latitude - centreLatitude
    
    return sqrt(pow(deltaLongitude, 2) + pow(deltaLatitude, 2))
    
}

func distance(vehicle: Vehicle, longitude: Double, latitude: Double) -> Double {
    let vehicleLongitude = vehicle.details.location.longitude
    let vehicleLatitude = vehicle.details.location.latitude
    
    return distance(latitude: vehicleLatitude, longitude: vehicleLongitude, centreLatitude: latitude, centreLongitude: longitude)
}

actor VehicleClient {
    private var server = Server()
    
    func vehicles(
        mapLocation: MapLocation,
        maxVehicles: Int,
        maxTime: Int
    ) async throws -> [Vehicle] {
        let minLongitude = mapLocation.centreLongitude - mapLocation.longitudeDelta
        let maxLongitude = mapLocation.centreLongitude + mapLocation.longitudeDelta
        let minLatitude = mapLocation.centreLatitude - mapLocation.latitudeDelta
        let maxLatitude = mapLocation.centreLatitude + mapLocation.latitudeDelta
        
        let feedURL: URL = getFeedURL(
            minLongitude: minLongitude,
            minLatitude: minLatitude,
            maxLongitude: maxLongitude,
            maxLatitude: maxLatitude
        )
        guard let data = try? await downloader.httpData(from: feedURL) else {
            throw VehicleError.networkError
        }
        let allVehicles = try decoder.decode(XML.self, from: data)
        
        // Only return recent buses if
        if (allVehicles.vehicles.count < maxVehicles) {
            return allVehicles.vehicles
        }
        
        var filteredVehicles: [Vehicle] = allVehicles.vehicles.filter(
            { $0.time.timeIntervalSinceNow > -3600}
        )
        
        filteredVehicles.sort {
            distance(
                vehicle: $0,
                longitude: mapLocation.centreLongitude,
                latitude: mapLocation.centreLatitude
            ) < distance(
                vehicle: $1,
                longitude: mapLocation.centreLongitude,
                latitude: mapLocation.centreLatitude
            )
        }
        
        
        
        if (filteredVehicles.count > maxVehicles) {
            return Array(filteredVehicles[0..<maxVehicles])
        }
        
        return filteredVehicles
    }
    
    func vehicle(vehicleRef: String) async throws -> Vehicle {
        let feedURL:URL = getFeedURL(vehicleRef: vehicleRef)
        guard let data = try? await downloader.httpData(from: feedURL) else {
            throw VehicleError.networkError
        }
        let vehicleData = try decoder.decode(XML.self, from: data)
        
        if (vehicleData.vehicles.count != 1) {
            throw VehicleError.dataFormatError
        }
        
        return vehicleData.vehicles[0]
    }

    private lazy var decoder: XMLDecoder = {
        let aDecoder = XMLDecoder()
        aDecoder.dateDecodingStrategy = .iso8601
        return aDecoder
    }()
    

    private func getFeedURL(
        minLongitude: Double,
        minLatitude: Double,
        maxLongitude: Double,
        maxLatitude: Double
    ) -> URL {
        let urlRoot = server.getURLRoot(path: "/location/area/")
        
        let path = minLatitude.description + "/" + minLongitude.description + "/" + maxLatitude.description + "/" + maxLongitude.description
        
        return urlRoot.appending(path: path)
    }
    
    private func getFeedURL(vehicleRef: String) -> URL {
        return server.getURLRoot(path: "/location/vehicle/" + vehicleRef)
    }
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
