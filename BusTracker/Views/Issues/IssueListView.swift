//
//  IssueListView.swift
//  BusTracker
//
//  Created by Zack Williams on 07-07-2025.
//

import SwiftUI
import MarkdownUI

struct IssueListView: View {
    @Environment(\.dismiss) var dismiss
    
    private let issueList: String? = {
        var issues: String? = nil

        if let path = Bundle.main.path(forResource: "Issues", ofType: "md") {
            issues = try? String(contentsOfFile: path, encoding: .utf8)
        }
        
        return issues
    }()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let issues = issueList {
                    Markdown(issues)
                } else {
                    Text("Issues not available")
                }
            }
            .padding(.horizontal)
            .toolbar(content: issueToolbar)
        }
        
    }
    
    @ToolbarContentBuilder
    func issueToolbar() -> some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("Done") {
                dismiss()
            }
        }
    }
}


#Preview {
    IssueListView()
}
