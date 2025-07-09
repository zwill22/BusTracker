//
//  DirectionsMenu.swift
//  BusTracker
//
//  Created by Zack Williams on 09-07-2025.
//

import SwiftUI

struct DirectionsMenu: View {
    @State var latitude: Double
    @State var longitude: Double
    
    func openURL(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func openMaps(appURL: String, webURL: String) {
        let url = URL(string: appURL)!
        let url2 = URL(string: webURL)!
            
        if UIApplication.shared.canOpenURL(url) {
            openURL(url)
        } else {
            openURL(url2)
        }
    }
    
    func openAppleMaps() {
        let appURL = "maps://?saddr=&daddr=\(latitude),\(longitude)&dirflg=w"
        let webURL = "https://maps.apple.com/directions?destination=\(latitude)%2C\(longitude)&source=&mode=walking"
        openMaps(appURL: appURL, webURL: webURL)
    }
    
    func openGoogleMaps() {
        let appURL = "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=walking"
        let webURL = "https://www.google.co.in/maps/dir/??saddr=&daddr=\(latitude),\(longitude)&directionsmode=walking"
        openMaps(appURL: appURL, webURL: webURL)
    }
    
    var body: some View {
        Text("Get Directions")
        Button {
            openAppleMaps()
        } label: {
            Text("Apple Maps")
        }
        
        Button {
            openGoogleMaps()
        } label: {
            Text("Google Maps")
        }

    }
}

#Preview {
    DirectionsMenu(latitude: 0, longitude: 0)
}
