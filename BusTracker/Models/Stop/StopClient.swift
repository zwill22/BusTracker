//
//  StopClient.swift
//  BusTracker
//
//  Created by Zack Williams on 14-05-2025.
//

import Foundation


func distance(stop: Stop, longitude: Double, latitude: Double) -> Double {
    guard let stopLongitude = stop.location?.longitude,
          let stopLatitude = stop.location?.latitude else {
        return .infinity
    }
    
    return distance(
        latitude: stopLatitude,
        longitude: stopLongitude,
        centreLatitude: latitude,
        centreLongitude: longitude
    )
}

actor StopClient {
    private var server = Server()
    private lazy var decoder = JSONDecoder();
    private let downloader: any HTTPDataDownloader
    
    func stops(mapLocation: MapLocation, maxStops: Int) async throws -> [Stop] {
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
            throw BusTrackerError.networkError
        }
        
        let allStops = try decoder.decode([Stop].self, from: data)
        
        var realStops = allStops.filter({$0.location != nil})
        
        if (realStops.count < maxStops) {
            return realStops
        }
        
        realStops.sort {
            distance(
                stop: $0,
                longitude: mapLocation.centreLongitude,
                latitude: mapLocation.centreLatitude
            ) < distance(
                stop: $1,
                longitude: mapLocation.centreLongitude,
                latitude: mapLocation.centreLatitude
            )
        }
        
        if (realStops.count > maxStops) {
            return Array(realStops[0..<maxStops])
        }
        
        return realStops
    }
    
    
    func stops(stopCodes: [String]) async throws -> [Stop] {
        if stopCodes.isEmpty {
            return []
        }
        let feedURL: URL = getFeedURL(stopCodes: stopCodes)
        
        guard let data = try? await downloader.httpData(from: feedURL) else {
            throw BusTrackerError.networkError
        }
        
        let stops = try decoder.decode([Stop].self, from: data)
        
        return stops
    }
    
    private func getFeedURL(
        minLongitude: Double,
        minLatitude: Double,
        maxLongitude: Double,
        maxLatitude: Double
    ) -> URL {
        let urlRoot = server.getURLRoot(path: "/stops/area/")
        
        let path = minLatitude.description + "/" + minLongitude.description + "/" + maxLatitude.description + "/" + maxLongitude.description
        
        return urlRoot.appending(path: path)
    }
    
    private func getFeedURL(stopCodes: [String]) -> URL {
        let codesURLString = stopCodes.joined(separator: ",")
        
        return server.getURLRoot(path: "/stops/codes/" + codesURLString)
    }
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
