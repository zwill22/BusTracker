//
//  AddressButton.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct AddressButton: View {
    @State private var copied = false {
        didSet {
            if copied == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        copied = false
                    }
                }
            }
        }
    }
    
    var address: String
    
    
    
    var body: some View {
        ZStack {
            Button(action: {
                UIPasteboard.general.string = address
                copied = true
            }) {
                DetailRow(string: address, image: Image(systemName: "building.fill"))
            }
            
            if copied {
                Text("Copied to Clipboard")
                    .background(.background)
            }
        }
    }
}

#Preview {
    AddressButton(address: "1 Swift Street, Anytown, AB1 2CD")
}
