//
//  Buses.swift
//  BusTracker
//
//  Created by Zack Williams on 12-11-2024.
//

import SwiftUI

struct Buses: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var provider: BusProvider
    @State var isLoading: Bool = false
    @State var selection: Set<String> = []
    @State private var error: BusError?
    @State private var hasError = false
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(provider.buses) { bus in
                    NavigationLink(destination: BusDetail(bus: bus)) {
                        BusRow(bus: bus)
                    }
                }
                .onDelete(perform: deleteBuses)
            }
            .listStyle(.inset)
            .navigationTitle(title)
            .refreshable {
                await fetchBuses()
            }
            .alert(isPresented: $hasError, error: error) {}
        }
        .task {
            await fetchBuses()
        }
    }

    var title: String {
        return "Buses"
    }
    
    func deleteBuses(at offsets: IndexSet) {
        provider.deleteBuses(atOffsets: offsets)
    }
    
    func deleteBuses(for codes: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.buses.enumerated() {
            if codes.contains(element.id) {
                offsetsToDelete.insert(index)
            }
        }
        deleteBuses(at: offsetsToDelete)
        selection.removeAll()
    }
    
    func fetchBuses() async {
        isLoading = true
        do {
            try await provider.fetchBuses()
        } catch {
            self.error = error as? BusError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        lastUpdated = Date().timeIntervalSince1970
        isLoading = false
    }
}

#Preview {
    Buses()
        .environmentObject(
            BusProvider(client: BusClient(downloader: TestDownloader()))
        )
}

