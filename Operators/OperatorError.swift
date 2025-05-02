//
//  OperatorError.swift
//  BusTracker
//
//  Created by Zack Williams on 17-04-2025.
//

import Foundation

enum OperatorError: Error {
    case missingData
    case networkError
    case dataFormatError
    case unexpectedError(error: Error)
}

extension OperatorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Cannot locate operator data",
                comment: ""
            )
        case .networkError:
            return NSLocalizedString(
                "Error fetching operator data from the server",
                comment: ""
            )
        case .dataFormatError:
            return NSLocalizedString(
                "Data is not in the expected format",
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
