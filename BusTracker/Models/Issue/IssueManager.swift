//
//  Issue.swift
//  BusTracker
//
//  Created by Zack Williams on 03-07-2025.
//

import Foundation

struct GitIssue: Codable, Identifiable {
    let title: String
    let description: String?
    let id: Int
}

@MainActor
@Observable
class IssueManager {
    var issues: [GitIssue] = []
    
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
    
    func fetchIssues() async throws {
        self.issues = try await client.getIssues()
    }
    
    init(client: IssueClient = IssueClient()) {
        self.client = client
    }
}

