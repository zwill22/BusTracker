//
//  StopDetailMap.swift
//  BusTracker
//
//  Created by Zack Williams on 19-05-2025.
//


import SwiftUI
import MapKit

struct StopDetailMap: View {
    private let height = CGFloat(24)
    private let place: VehiclePlace?
    private let tintColour: Color
    private let stopType: StopType?
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion())
    
    
    init(stop: Stop) {
        if let location = stop.location {
            self.place = VehiclePlace(location: location)
            self.stopType = stop.stopType
        } else {
            self.stopType = nil
            self.place = nil
        }
        
        self.tintColour = .primary.opacity(0.8)
    }
    
    var body: some View {
        Map(position: $position) {
            if let location = place?.location {
                if let stopType = stopType {
                    Annotation("", coordinate: location) {
                        stopType.view(height: 32)
                    }
                }
            }
        }
            .onAppear {
                guard let place else { return }
                withAnimation {
                    position = .region(MKCoordinateRegion(center: place.location, span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)))
                }
            }
    }
}

