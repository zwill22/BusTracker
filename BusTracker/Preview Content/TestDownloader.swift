//
//  TestDownloader.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

private func simulateHTTPData(data: Data) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return data
}

class TestVehicleDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        return try await simulateHTTPData(data: testVehicleData)
    }
}

class TestOperatorDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        return try await simulateHTTPData(data: testOperatorData)
    }
}

class TestStopDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        return try await simulateHTTPData(data: testStopData)
    }
}
