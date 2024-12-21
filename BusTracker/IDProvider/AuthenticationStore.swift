//
//  AuthenticationStore.swift
//  BusTracker
//
//  Created by Zack Williams on 17-12-2024.
//

import Foundation

@MainActor
class AuthenticationStore: ObservableObject {
    @Published var authentication: Authentication = .init()
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("authentication.data")
    }
    
    func load() async throws {
        let task = Task<Authentication, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return Authentication.init()
            }
            let authentication = try JSONDecoder().decode(Authentication.self, from: data)
            return authentication
        }
        let authentication = try await task.value
        self.authentication = authentication
    }
    
    func save(authentication: Authentication) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(authentication)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
