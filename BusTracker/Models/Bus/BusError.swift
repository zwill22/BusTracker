//
//  BusError.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import Foundation

enum BusError: Error {
    case missingData
    case networkError
    case dataFormatError
    case unexpectedError(error: Error)
}

extension BusError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a bus missing a valid code, location, or time.",
                comment: ""
            )
        case .networkError:
            return NSLocalizedString(
                "Error fetching bus data from the server",
                comment: ""
            )
        case .dataFormatError:
            return NSLocalizedString(
                "Data returned from server was not in the expected format",
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
