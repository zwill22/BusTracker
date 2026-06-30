//
//  IssueRow.swift
//  BusTracker
//
//  Created by Zack Williams on 10-07-2025.
//

import SwiftUI

struct IssueRow: View {
    @State var issue: GitIssue
    
    var body: some View {
        DisclosureGroup {
            if let description = issue.description {
                Text(description)
            }
        } label: {
            Text(issue.title)
        }
    }
}

#Preview {
    let issue = GitIssue(
        title: "Not all issues are shown",
        description: "Need to add more issues to GitHub",
        id: UUID().hashValue
    )
    
    IssueRow(issue: issue)
}
