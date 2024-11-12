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
            return allBuses.buses
        }
    }
    
    private lazy var decoder: XMLDecoder = {
        let aDecoder = XMLDecoder()
        aDecoder.dateDecodingStrategy = .iso8601
        return aDecoder
    }()

    private let feedURL = URL(string: "https://data.bus-data.dft.gov.uk/api/v1/datafeed?boundingBox=-2.93,53.374,-3.085,53.453")!
    
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
}
