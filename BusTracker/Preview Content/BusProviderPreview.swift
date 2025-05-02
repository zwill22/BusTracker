//
//  BusProviderPreview.swift
//  BusTracker
//
//  Created by Zack Williams on 10-04-2025.
//

extension BusProvider {
    static var preview: BusProvider {
        
        var client = BusClient(downloader: TestDownloader())
        
        var provider = BusProvider(client: client)
        
        Task {
            do {
                try await provider.fetchBuses(position: .automatic)
            } catch {
                print("Unable to fetch buses")
            }
        }
        
        return provider
    }
}
