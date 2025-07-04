//
//  ReportIssueView.swift
//  BusTracker
//
//  Created by Zack Williams on 03-07-2025.
//

import SwiftUI

struct ReportIssueView: View {
    @State private var issueTitle: String = ""
    @State private var issueDescription: String = ""
    
    @State private var isLoading: Bool = false
    @State private var isSubmitting: Bool = false
    @State private var error: StopError?
    @State private var hasError: Bool = false
    
    @State private var issueSubmitted: Bool = false
    @State private var issueManager: IssueManager = IssueManager()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section(header: Text("Issue title")) {
                    TextField("Title", text: $issueTitle)
                }
                Section(header: Text("Issue description")) {
                    TextField("Description", text: $issueDescription, axis: .vertical)
                        .lineLimit(10...20)
                }
            }
            .toolbar(content: issueToolbar)
            .alert(
                error?.localizedDescription ?? "An unexpected error occurred",
                isPresented: $hasError
            ) {
                Button("OK") {
                    dismiss()
                }
            }
            .alert(
                "Issue submitted successfully!",
                isPresented: $issueSubmitted
            ) {
                Button("Thank you") {
                    dismiss()
                }
            }
        }
        .task {
            await checkClient()
        }
        .navigationTitle("Report Issue")
    }
    
    private func checkClient() async {
        isLoading = true
        do {
            try await issueManager.checkClientAvailability()
        } catch {
            self.error = error as? StopError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        isLoading = false
    }
    
    
    func submitIssue() {
        isSubmitting = true
        Task {
            do {
                try await issueManager.sendIssue(
                    title: issueTitle,
                    description: issueDescription
                )
            } catch {
                self.error = error as? StopError ?? .unexpectedError(error: error)
                self.hasError = true
            }
        }
        
        isSubmitting = false
        issueSubmitted = true
    }
}

#Preview {
    ReportIssueView()
}
