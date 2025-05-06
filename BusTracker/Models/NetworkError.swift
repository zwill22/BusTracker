//
//  NetworkError.swift
//  BusTracker
//
//  Created by Zack Williams on 06-05-2025.
//

import Foundation

enum NetworkError: Error {
    case networkError
    case unexpectedError(error: Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString(
                "Error fetching data from the server",
                comment: ""
            )

        case .unexpectedError(let error):
            return NSLocalizedString(
                "Received unexpected error: \(error.localizedDescription)",
                comment: ""
            )
        }
    }
}
