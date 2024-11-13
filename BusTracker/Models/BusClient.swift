//
//  BusClient.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation
import XMLCoder

actor BusClient {
    let apiKey: String? = nil
    
    var buses: [Bus] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allBuses = try decoder.decode(XML.self, from: data)
            
            return allBuses.buses.filter({ $0.time.timeIntervalSinceNow > -3600})
        }
    }

    private lazy var decoder: XMLDecoder = {
        let aDecoder = XMLDecoder()
        aDecoder.dateDecodingStrategy = .iso8601
        return aDecoder
    }()
    
    private let feedURL: URL = {
        let part1 = "https://data.bus-data.dft.gov.uk/api/v1/datafeed?"
        let part2 = "boundingBox=-2.93,53.374,-3.085,53.453"
        
        var apiKey: String? = nil
        if let path = Bundle.main.path(forResource: "api_key.txt", ofType: nil) {
            apiKey = try? String(contentsOfFile: path, encoding: .utf8)
        }
        
        if apiKey != nil {
            print(part1 + "api_key=" + apiKey!.trimmingCharacters(in: .newlines) + "&" + part2)
            return URL(string: part1 + "api_key=" + apiKey!.trimmingCharacters(in: .newlines) + "&" + part2)!
        } else {
            return URL(string: part1 + part2)!
        }
    }()
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
