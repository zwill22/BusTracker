//
//  ContentView.swift
//  Operators
//
//  Created by Zack Williams on 17-04-2025.
//

import SwiftUI

struct Operators: View {
    @Bindable var provider: OperatorProvider
    
    @AppStorage("operatorsLastUpdated")
    var operatorsLastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @State var isLoading: Bool = false
    @State private var error: OperatorError?
    @State private var hasError = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(provider.filteredOperators) { busOperator in
                    NavigationLink(
                        destination: OperatorDetailView(
                            transportOperator: busOperator
                        )) {
                        OperatorRow(busOperator: busOperator)
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle(title)
            .alert(isPresented: $hasError, error: error) {}
            .padding(EdgeInsets(top: 0, leading:5, bottom: 0, trailing: 5))
            .searchable(text: $provider.searchText)
        }
        .task {
            await fetchOperators()
        }
    }

    var title: String {
        return "Transport Operators"
    }
    
                
    func fetchOperators() async {
        isLoading = true
        do {
            try await provider.fetchOperators()
            operatorsLastUpdated = Date().timeIntervalSince1970
        } catch {
            self.error = error as? OperatorError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        isLoading = false
    }
}

#Preview {
    Operators(provider: OperatorProvider.preview)
}

