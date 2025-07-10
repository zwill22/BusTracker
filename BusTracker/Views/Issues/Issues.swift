//
//  IssueListView.swift
//  BusTracker
//
//  Created by Zack Williams on 07-07-2025.
//

import SwiftUI

struct Issues: View {
    @AppStorage("issuesLastUpdated")
    var issuesLastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @Bindable var issueManager: IssueManager
    
    @State var isLoading: Bool = false
    @State private var error: VehicleError?
    @State private var hasError: Bool = false
    @State private var addIssue: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(issueManager.issues) { issue in
                    IssueRow(issue: issue)
                }
            }
            .listStyle(.inset)
            .toolbar(content: issueToolbar)
            .alert(isPresented: $hasError, error: error) {}
            .navigationTitle("Issues")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await fetchIssues()
        }
        .sheet(isPresented: $addIssue) {
            ReportIssueView(issueManager: issueManager)
        }
    }
    
    func fetchIssues() async {
        isLoading = true
        do {
            try await issueManager.fetchIssues()
        } catch {
            self.error = error as? VehicleError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        issuesLastUpdated = Date().timeIntervalSince1970
        isLoading = false
    }
    
    @ToolbarContentBuilder
    func reportIssue() -> some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            if isLoading {
                ProgressView()
            } else {
                Button(
                    "Add Issue",
                    systemImage: "plus") {
                        addIssue = true
                    }
            }
        }
    }
    
    @ToolbarContentBuilder
    func statusBar() -> some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton(isLoading: $isLoading) {
                Task {
                    await fetchIssues()
                }
            }
            Spacer()
            ToolbarStatus(
                isLoading: isLoading,
                lastUpdated: issuesLastUpdated,
                count: issueManager.issues.count,
                itemType: "Issues"
            )
            Spacer()
        }
    }
    
    @ToolbarContentBuilder
    func issueToolbar() -> some ToolbarContent {
        reportIssue()
        statusBar()
    }
}


#Preview {
    Issues(issueManager: IssueManager())
}
