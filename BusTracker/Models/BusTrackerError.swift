//
//  BusTrackerError.swift
//  BusTracker
//
//  Created by Zack Williams on 10-07-2025.
//

import Foundation

enum BusTrackerError: Error {
    case missingData
    case networkError
    case dataFormatError
    case missingIssueValues
    case unexpectedError(error: Error)
}

extension BusTrackerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Object is missing data",
                comment: ""
            )
        case .networkError:
            return NSLocalizedString(
                "Error fetching data from the server",
                comment: ""
            )
        case .dataFormatError:
            return NSLocalizedString(
                "Data not in expected format",
                comment: ""
            )
        case .missingIssueValues:
            return NSLocalizedString(
                "Cannot submit issues without required values",
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
