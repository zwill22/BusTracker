//
//  OperatorDetailView.swift
//  Operators
//
//  Created by Zack Williams on 02-05-2025.
//

import SwiftUI

struct OperatorDetailView: View {
    var transportOperator: Operator
    var action: () -> Void = {}
    
    var body: some View {
        VStack {
            OperatorBlock(transportOperator: transportOperator).padding(.top)
            Text(transportOperator.mode.rawValue).font(.title2).padding(.bottom)
            Text(transportOperator.name).font(.largeTitle).padding(.bottom)
            List {
                if let website = transportOperator.website {
                    WebButton(inputAddress: website)
                }
                if let twitter = transportOperator.twitter {
                    TwitterButton(twitterHandle: twitter)
                }
                if let address = transportOperator.address {
                    AddressButton(address: address)
                }
                
                ForEach(transportOperator.enquiries, id: \.self) { enquiry in
                    HStack {
                        let imageName = switch enquiry.type {
                        case .email:
                            "envelope.fill"
                        case .phone:
                            "phone.fill"
                        default:
                            "message.circle.fill"
                        }
                        Image(systemName: imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .padding(.trailing)
                        Text(enquiry.string)
                    }.padding(.vertical)
                }
            }
        }
    }
}

#Preview {
    OperatorDetailView(transportOperator: Operator.preview)
}
