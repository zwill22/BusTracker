//
//  StopClient.swift
//  BusTracker
//
//  Created by Zack Williams on 14-05-2025.
//

import Foundation
import CodableCSV

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
            throw VehicleError.networkError
        }
        
        let allStops = try decoder.decode([Stop].self, from: data)
        
        return allStops
    }
    
    func stops(stopCodes: [String]) async throws -> [Stop] {
        let feedURL: URL = getFeedURL(stopCodes: stopCodes)
        
        guard let data = try? await downloader.httpData(from: feedURL) else {
            throw VehicleError.networkError
        }
        
        let stops = try decoder.decode([Stop].self, from: data)
        
        return stops
    }
    
    func checkVersion() async throws {
        let feedURL: URL = server.getURLRoot(path: "/version")
        
        guard let version = try? await downloader.httpData(from: feedURL) else {
            throw VehicleError.networkError
        }
        
        let version_string = String(data: version, encoding: .utf8)!
        
        if version_string != "0.4.0" {
            throw VehicleError.missingData
        }
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
