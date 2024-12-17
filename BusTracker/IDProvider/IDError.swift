//
//  IDError.swift
//  BusTracker
//
//  Created by Zack Williams on 17-12-2024.
//

import Foundation

enum IDError: Error {
    case openIDError(error: String)
    case expiredAuthenticationError
    case authenticationError(error: String)
    case unexpectedError(error: Error)
}

extension IDError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .openIDError(let error):
            return NSLocalizedString(
                "OpenID Error: \(error)",
                comment: "Error calling the OpenID API"
            )
        case .expiredAuthenticationError:
            return NSLocalizedString(
                "Authentication expired",
                comment: "Authentication has expired"
            )
        case .authenticationError(let error):
            return NSLocalizedString(
                "Authentication error: \(error)",
                comment: "An error during the authentication process"
            )
        case .unexpectedError(let error):
            return NSLocalizedString(
                "Received unexpected error: \(error.localizedDescription)",
                comment: "Unexpected error"
            )
        }
    }
}
