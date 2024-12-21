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
    
    @Binding var authentication: Authentication
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
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
            .toolbar(content: toolbarContent)
            .refreshable {
                await fetchBuses()
            }
            .alert(isPresented: $hasError, error: error) {}
            .padding(EdgeInsets(top: 0, leading:5, bottom: 0, trailing: 5))
        }
        .task {
            await fetchBuses()
        }
        .onChange(of: scenePhase, initial: false) { oldPhase, newPhase in
            if newPhase == .inactive {
                saveAction()
            }
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
    Buses(authentication: .constant(Authentication.sampleData),
          saveAction: {})
        .environmentObject(
            BusProvider(client: BusClient(downloader: TestDownloader()))
        )
}

