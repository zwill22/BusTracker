//
//  IssueToolbar.swift
//  BusTracker
//
//  Created by Zack Williams on 04-07-2025.
//

import SwiftUI

extension ReportIssueView {
    
    @ToolbarContentBuilder
    func issueToolbar() -> some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
                dismiss()
            }
        }
        
        ToolbarItem(placement: .confirmationAction) {
            Button("Submit") {
                submitIssue()
                dismiss()
            }
        }
    }
}
