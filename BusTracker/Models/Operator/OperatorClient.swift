//
//  OperatorClient.swift
//  Operators
//
//  Created by Zack Williams on 17-04-2025.
//

import Foundation
import XMLCoder

actor OperatorClient {
    private let feedURL: URL = Server().getURLRoot(path: "/operators/data")
    
    private lazy var decoder = JSONDecoder();
    
    private let downloader: any HTTPDataDownloader
    
    var operators: [Operator] {
        get async throws {
            guard let data = try? await downloader.httpData(from: feedURL) else {
                throw OperatorError.networkError
            }
            let allOperators = try decoder.decode([Operator].self, from: data)
            
            return allOperators
        }
    }
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
