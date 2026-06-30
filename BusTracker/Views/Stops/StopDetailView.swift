//
//  StopDetailView.swift
//  BusTracker
//
//  Created by Zack Williams on 19-05-2025.
//

import SwiftUI

struct StopDetailView: View {
    var stop: Stop
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if stop.location != nil {
                    StopDetailMap(stop: stop)
                        .ignoresSafeArea(.container)
                }
                
                HStack{
                    
                    VStack(alignment: .leading) {
                        if let landmark = stop.landmark {
                            Text(landmark).bold().font(.title)
                                .lineLimit(2, reservesSpace: true).padding(.bottom)
                        } else {
                            Text(stop.name).font(.title).lineLimit(2, reservesSpace: true).bold().padding(.bottom)
                        }
                        if let street = stop.street {
                            Text(street).font(.title2)
                        }
                        Text(stop.locality).font(.title2)
                        if let parentLocality = stop.parentLocality {
                            Text(parentLocality).font(.title3)
                        }
                        if let town = stop.town {
                            Text(town).font(.title3)
                        }
                        if let suburb = stop.suburb {
                            Text(suburb).font(.title3)
                        }
                        
                        if let location = stop.location {
                            Menu {
                                DirectionsMenu(latitude: location.latitude, longitude: location.longitude)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(3))))").font(.headline)
                                    Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(3))))").font(.headline)
                                }
                            }.foregroundStyle(.primary)
                        }
                    }
                }.padding(.all)
            }
            .toolbar(content: toolbarContent)
        }
    }
    
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            if let location = stop.location {
                Menu {
                    DirectionsMenu(latitude: location.latitude, longitude: location.longitude)
                } label: {
                    Image(systemName: "figure.walk")
                }
            }
        }
    }
}

#Preview {
    StopDetailView(stop: Stop.preview)
}
