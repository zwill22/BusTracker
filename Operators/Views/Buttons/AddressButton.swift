//
//  AddressButton.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct AddressButton: View {
  var address: String
    
    
    
    var body: some View {
        BaseButton(
            strings: address.components(separatedBy: ", "),
            image: Image(systemName: "building.fill"))
    }
}

#Preview {
    AddressButton(address: "1 Swift Street, Anytown, AB1 2CD")
}
