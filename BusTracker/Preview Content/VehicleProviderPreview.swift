//
//  VehicleProviderPreview.swift
//  BusTracker
//
//  Created by Zack Williams on 10-04-2025.
//

extension VehicleProvider {
    static var preview: VehicleProvider {
        
        let client = VehicleClient(downloader: TestVehicleDownloader())
        
        let provider = VehicleProvider(client: client)
        
        Task {
            do {
                try await provider.fetchVehicles(position: .automatic)
            } catch {
                print("Unable to fetch vehicles")
            }
        }
        
        return provider
    }
}
