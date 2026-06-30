//
//  OperatorProviderPreview.swift
//  BusTracker
//
//  Created by Zack Williams on 05-05-2025.
//


extension OperatorProvider {
    static var preview: OperatorProvider {
        
        let client = OperatorClient(downloader: TestOperatorDownloader())
        
        let provider = OperatorProvider(client: client)
        
        Task {
            do {
                try await provider.fetchOperators()
            } catch {
                print("Unable to fetch operators")
            }
        }
        
        return provider
    }
}
