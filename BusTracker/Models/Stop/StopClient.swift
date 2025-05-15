//
//  StopClient.swift
//  BusTracker
//
//  Created by Zack Williams on 14-05-2025.
//

import Foundation
import CodableCSV

actor StopClient {
    private let csvURL = URL(filePath: "Stops.csv")!
    
    private var decoder: CSVDecoder.Lazy {
        get async throws {
            let lazyDecoder = try CSVDecoder {
                $0.encoding = .utf8
                $0.delimiters.field = ","
                $0.headerStrategy = .firstLine
                $0.bufferingStrategy = .sequential
                $0.presample = false
            }.lazy(from: csvURL)
            
            return lazyDecoder
        }
    }
    
    var stops: [Stop] {
        get async throws {
            let allStops = try await decoder.map { try $0.decode(Stop.self) }
            
            return allStops
        }
    }
}
