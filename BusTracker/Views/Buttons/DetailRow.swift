//
//  DetailRow.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct DetailRow: View {
    var strings: [String]
    var image: Image
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .padding(.trailing)
            VStack(alignment: .leading) {
                ForEach(strings, id: \.self) { string in
                    Text(string).lineLimit(1)
                }
            }
        }.padding(.vertical)
    }
}

#Preview {
    DetailRow(strings: ["https://www.apple.com"], image: Image(systemName: "apple.logo"))
}
