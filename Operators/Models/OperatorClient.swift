//
//  OperatorClient.swift
//  Operators
//
//  Created by Zack Williams on 17-04-2025.
//

import Foundation
import XMLCoder

enum CacheEntry {
    case inProgress(Task<Operator, Error>)
    case ready(Operator)
}

final class CacheEntryObject {
    let entry: CacheEntry
    
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

actor OperatorClient {
    private let operatorCache: NSCache<NSString, CacheEntryObject> = NSCache()
    
    private let feedURL: URL = URL(string: "http://localhost:5134/operators/data")!
    
    private lazy var decoder = JSONDecoder();
    
    private let downloader: any HTTPDataDownloader
    
    var operators: [Operator] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allOperators = try decoder.decode([Operator].self, from: data)
            
            return allOperators
        }
    }
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
