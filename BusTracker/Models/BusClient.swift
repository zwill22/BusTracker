//
//  BusClient.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import XMLCoder

func distance(bus: Bus, userLongitude: Double, userLatitude: Double) -> Double {
    let busLongitude = bus.details.location.longitude
    let busLatitude = bus.details.location.latitude
    
    let deltaLongitude = busLongitude - userLongitude
    let deltaLatitude = busLatitude - userLatitude
    
    return sqrt(pow(deltaLongitude, 2) + pow(deltaLatitude, 2))
}

actor BusClient {
    
    func buses(
        minLongitude: Double, minLatitude: Double,
        maxLongitude: Double, maxLatitude: Double,
        userLongitude: Double, userLatitude: Double
    ) async throws -> [Bus] {
        let feedURL: URL = getFeedURL(minLongitude: minLongitude, minLatitude: minLatitude, maxLongitude: maxLongitude, maxLatitude: maxLatitude)
        let data = try await downloader.httpData(from: feedURL)
        let allBuses = try decoder.decode(XML.self, from: data)
        
        // Only return recent buses if
        if (allBuses.buses.count < 500) {
            return allBuses.buses
        }
        
        var filteredBuses: [Bus] = allBuses.buses.filter({ $0.time.timeIntervalSinceNow > -3600})
        
        filteredBuses.sort { distance(bus: $0, userLongitude: userLongitude, userLatitude: userLatitude) < distance(bus: $1, userLongitude: userLongitude, userLatitude: userLatitude) }
        
        
        
        if (filteredBuses.count > 500) {
            return Array(filteredBuses[0..<500])
        }
        
        return filteredBuses
    }
    
    func bus(vehicleRef: String) async throws -> Bus {
        let feedURL:URL = getFeedURL(vehicleRef: vehicleRef)
        let data = try await downloader.httpData(from: feedURL)
        let busData = try decoder.decode(XML.self, from: data)
        
        if (busData.buses.count != 1) {
            throw BusError.networkError
        }
        
        return busData.buses[0]
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
        
        print(result)
        return URL(string: result)!
    }
    
    private func getFeedURL(vehicleRef: String) -> URL {
        let urlRoot = "http://localhost:5134/vehicle/"
        
        let result = urlRoot + vehicleRef
        
        print(result)
        return URL(string: result)!
    }
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
