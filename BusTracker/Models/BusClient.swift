//
//  BusClient.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import XMLCoder

actor BusClient {
    
    var buses: [Bus] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allBuses = try decoder.decode(XML.self, from: data)
            
            if (allBuses.buses.count > 100) {
                return allBuses.buses.filter({ $0.time.timeIntervalSinceNow > -3600})
            }
            
            return allBuses.buses
        }
    }

    private lazy var decoder: XMLDecoder = {
        let aDecoder = XMLDecoder()
        aDecoder.dateDecodingStrategy = .iso8601
        return aDecoder
    }()
    
    private let feedURL: URL = {
        let urlRoot = "http://127.0.0.1:5000/location/"
        let minLongitude: Double = -3.085
        let maxLongitude: Double = -2.93
        let minLatitude: Double = 53.374
        let maxLatitude: Double = 53.453
        
        
        let result = urlRoot + minLatitude.description + "/" + minLongitude.description + "/" + maxLatitude.description + "/" + maxLongitude.description
        
        print(result)
        return URL(string: result)!
    }()
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
