//
//  Settings.swift
//  BusTracker
//
//  Created by Zack Williams on 28-05-2025.
//

import SwiftUI

struct Settings: View {
    @Bindable var locationProvider: LocationProvider
    @Bindable var operatorProvider: OperatorProvider
    @Bindable var stopProvider: StopProvider
    @Bindable var vehicleProvider: VehicleProvider
    @Bindable var issueManager: IssueManager
    
    var body: some View {
        NavigationStack {
            SettingsBlock(height: 80).padding(.top)
            Text("Settings").font(.title).padding(.bottom)
            Form {
                Section(header: Text("Vehicle Options")) {
                    VehicleSettings(
                        maxVehicles: $vehicleProvider.maxVehicles,
                        maxTime: $vehicleProvider.maxTime,
                        timeout: $vehicleProvider.timeout,
                        refreshRate: $vehicleProvider.refreshInterval,
                        autoRefresh: $vehicleProvider.autoRefresh
                    )
                }
                Section(header: Text("Operator settings")) {
                    OperatorSettings(operators: $operatorProvider.vehicleOperators)
                }
                
                Section(header: Text("Stop settings")) {
                    StopSettings(maxStops: $stopProvider.maxStops)
                }
                
                Section(header: Text("Location settings")) {
                    LocationSettings(
                        defaultDelta: $locationProvider.defaultDelta,
                        maxDelta: $locationProvider.maxDelta
                    )
                }
                
                Section(header: Text("Data Sources")) {
                    BaseLink(
                        label: "UK Bus Open Data Service",
                        urlString: "https://data.bus-data.dft.gov.uk",
                        image: Image(systemName: "tram.circle").renderingMode(.template)
                    )
                    
                    BaseLink(
                        label: "National Operator Code dataset (NOC)",
                        urlString: "https://www.travelinedata.org.uk/traveline-open-data/transport-operations/about-2/",
                        image: Image(systemName: "lightrail.fill")
                    )
                }
                
                Section(header: Text("Additional information")) {
                    BaseLink(
                        label: "GitHub Repo",
                        urlString: "https://github.com/zwill22/BusTracker",
                        image: Image(uiImage: .githubLogo).renderingMode(.template)
                    )
                    
                    NavigationLink(destination: IssueListView(issueManager: issueManager)) {
                        DetailRow(
                            strings: ["Issues"],
                            image: Image(systemName: "exclamationmark.triangle")
                        )
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Support my work:")
                        HStack {
                            Spacer()
                            BuyMeButton().frame(height: 60)
                            Spacer()
                        }
                    }
                }
            }
        }
    }

}

#Preview {
    Settings(
        locationProvider: LocationProvider(),
        operatorProvider: OperatorProvider.preview,
        stopProvider: StopProvider.preview,
        vehicleProvider: VehicleProvider.preview,
        issueManager: IssueManager()
    )
}
