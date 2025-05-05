//
//  OperatorPreview.swift
//  Operators
//
//  Created by Zack Williams on 24-04-2025.
//

import Foundation

extension Operator {
    static var preview: Operator {
        let enquiries: [Enquiry] = [
            Enquiry(string: "+44 20 7123 4567"),
            Enquiry(string: "example@example.com")
        ]
        let previewOperator = Operator(
            id: "135480",
            name: "Example Bus Service",
            opCode: "ExBS",
            mode: .bus,
            enquiries: enquiries,
            address: "1 Bus Street, Cardiff, CF10 1AA",
            twitter: "@exampleHandle",
            website: "https://www.example.com"
        )
    
        return previewOperator
    }
}
