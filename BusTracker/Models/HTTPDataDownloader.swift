//
//  HTTPDataDownloader.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

let validStatus = 200..<300

protocol HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw BusError.networkError
        }
        
        return data
    }
}
