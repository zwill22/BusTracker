//
//  OperatorProvider.swift
//  Operators
//
//  Created by Zack Williams on 17-04-2025.
//

import Foundation

@MainActor
class OperatorProvider: ObservableObject {
    @Published var vehicleOperators: [Operator] = []
    @Published var searchText: String = ""
    @Published var initialised: Bool = false
    
    private let client: OperatorClient
    
    func fetchOperators() async throws {
        if initialised {
            return
        }
        
        let operators = try await client.operators;
        self.vehicleOperators = operators
        self.initialised = true
    }
    
    var filteredOperators: [Operator] {
        guard !searchText.isEmpty else {
            return vehicleOperators
        }
        
        return vehicleOperators.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.opCode.lowercased().contains(searchText.lowercased())
        
        }
    }
    
    init(client: OperatorClient = OperatorClient()) {
        self.client = client
    }
}
