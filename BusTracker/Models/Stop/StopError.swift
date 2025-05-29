//
//  StopError.swift
//  BusTracker
//
//  Created by Zack Williams on 20-05-2025.
//

import Foundation

enum StopError: Error {
    case missingData
    case networkError
    case dataFormatError
    case versionError(_ version_string: String)
    case unexpectedError(error: Error)
}

extension StopError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a stop missing a valid code, location, or time.",
                comment: ""
            )
        case .networkError:
            return NSLocalizedString(
                "Error fetching stop data from the server",
                comment: ""
            )
        case .dataFormatError:
            return NSLocalizedString(
                "Data returned from server was not in the expected format",
                comment: ""
            )
        case .versionError(let version_string):
            return NSLocalizedString(
                "Invalid API version \(version_string)",
                comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString(
                "Received unexpected error: \(error.localizedDescription)",
                comment: ""
            )
        }
    }
}

