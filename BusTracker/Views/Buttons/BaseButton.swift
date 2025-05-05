//
//  BaseButton.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct BaseButton: View {
    var strings: [String]
    var image: Image
    var action: () -> Void = {}
    
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
    
    
    
    var body: some View {
        ZStack {
            Button(action: action) {
                HStack {
                    DetailRow(strings: strings, image: image)
                    Spacer()
                }.contentShape(Rectangle())
            }.foregroundColor(.primary)
                .simultaneousGesture(TapGesture(count: 2).onEnded {
                    #if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
                    UIPasteboard.general.string = String(strings.joined(separator: " "))
                    #endif
                    copied = true
                })
            
            
            if copied {
                Text("Copied to Clipboard")
                    .background(.background)
            }
        }
    }
}

#Preview {
    BaseButton(strings: ["Big String"], image: Image(systemName: "square.and.arrow.up"))
}
