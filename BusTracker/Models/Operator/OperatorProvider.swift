//
//  OperatorProvider.swift
//  Operators
//
//  Created by Zack Williams on 17-04-2025.
//

import Foundation

@MainActor
class OperatorProvider: ObservableObject {
    @Published var busOperators: [Operator] = []
    @Published var searchText: String = ""
    
    private let client: OperatorClient
    
    func fetchOperators() async throws {
        let operators = try await client.operators;
        self.busOperators = operators
    }
    
    func fetchOperator(opCode: String) async throws -> Operator {
        let operators = busOperators.filter { $0.opCode == opCode }
        
        if operators.count == 1 {
            return operators[0]
        }
        
        throw OperatorError.dataFormatError
    }
    
    var filteredOperators: [Operator] {
        guard !searchText.isEmpty else {
            return busOperators
        }
        
        return busOperators.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.opCode.lowercased().contains(searchText.lowercased())
        
        }
    }
    
    init(client: OperatorClient = OperatorClient()) {
        self.client = client
    }
}
