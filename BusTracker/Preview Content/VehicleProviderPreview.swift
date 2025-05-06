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
        
        let mapLocation = MapLocation(
            centreLongitude: -123.1207,
            centreLatitude: 49.2827,
            longitudeDelta: 0.1,
            latitudeDelta: 0.1
        )
        
        Task {
            do {
                try await provider.fetchVehicles(mapLocation: mapLocation)
            } catch {
                print("Unable to fetch vehicles")
            }
        }
        
        return provider
    }
}
