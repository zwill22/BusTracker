//
//  IssueClient.swift
//  BusTracker
//
//  Created by Zack Williams on 03-07-2025.
//

import Foundation
import OctoKit

actor IssueClient {
    private let owner: String = "zwill22"
    private let repository: String = "BusTracker"
    
    private let config: TokenConfiguration = {
        var token: String? = nil
        
        if let path = Bundle.main.path(forResource: "token.txt", ofType: nil) {
            token = try? String(contentsOfFile: path, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return TokenConfiguration(token)
    }()
    
    func checkConfig() async throws {
        _ = try await Octokit(config).me()
    }
    
    func submit(title: String, description: String) async throws {
        _ = try await Octokit(config).postIssue(
            owner: owner,
            repository: repository,
            title: title,
            body: description
        )
    }
    
    func getIssues() async throws -> [GitIssue] {
        let allIssues = try await Octokit(config).issues(owner: owner, repository: repository, state: .open)
        
        let issues = allIssues.map { GitIssue(title: $0.title ?? "", description: $0.body, id: $0.id) }
        
        return issues.filter { $0.title != "" }
    }
}
