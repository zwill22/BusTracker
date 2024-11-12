//
//  TestDownloader.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testBusData
    }
}
