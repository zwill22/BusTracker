//
//  StopProviderPreview.swift
//  BusTracker
//
//  Created by Zack Williams on 19-05-2025.
//

extension StopProvider {
    static var preview: StopProvider {
        
        let client = StopClient(downloader: TestStopDownloader())
        
        let provider = StopProvider(client: client)

        Task {
            do {
                try await provider.fetchStopCodes(codes: [])
            } catch {
                print("Unable to fetch vehicles")
            }
        }
        
        return provider
    }
}
