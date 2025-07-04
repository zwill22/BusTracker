//
//  Issue.swift
//  BusTracker
//
//  Created by Zack Williams on 03-07-2025.
//

import Foundation

@MainActor
class IssueManager {
    private let client: IssueClient
    
    func checkClientAvailability() async throws {
        try await client.checkConfig()
    }
    
    func sendIssue(title: String, description: String) async throws {
        if title.isEmpty || description.isEmpty {
            throw VehicleError.missingData
        }
        try await client.submit(
            title: title,
            description: description
        )
    }
    
    init(client: IssueClient = IssueClient()) {
        self.client = client
    }
}

