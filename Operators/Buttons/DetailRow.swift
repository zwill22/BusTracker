//
//  DetailRow.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct DetailRow: View {
    var string: String
    var image: Image
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .padding(.trailing)
            Text(string)
        }.padding(.vertical)
    }
}

#Preview {
    DetailRow(string: "https://www.apple.com", image: Image(systemName: "apple.logo"))
}
