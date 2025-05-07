//
//  main.swift
//  BusTrackerLogo
//
//  Created by Zack Williams on 06-05-2025.
//

import Foundation
import SwiftUI
import CoreImage

struct LogoView: View {
    let cornerRadius: CGFloat = 64
    let imageSize: CGFloat = 1024
    let circleRadius: CGFloat = 896
    let busSize: CGFloat = 576
    let background: RadialGradient = RadialGradient(colors: [.white, .gray], center: .center, startRadius: 0, endRadius: 1024)
    let busColour: Color = .blue
    let bus: String = "bus.fill"
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(background)
                .frame(width: imageSize, height: imageSize)
            
            Circle()
                .strokeBorder(lineWidth: 64)
                .frame(width: circleRadius, height: circleRadius)
                .foregroundStyle(busColour)
            
            Image(systemName: bus)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(busColour)
                        .frame(width: busSize, height: busSize)
                
        }

    }
}

func write(cgimage: CGImage, to url: URL) throws {
    let ciContext = CIContext()
    let ciImage = CIImage(cgImage: cgimage)
    try ciContext.writePNGRepresentation(of: ciImage, to: url, format: .RGBA8, colorSpace: ciImage.colorSpace!)
    
}

@MainActor
class Logo {
    var logo: CGImage?
    
    init()  {
        let view = LogoView()
        let image = ImageRenderer(content: view).cgImage
        self.logo = image
    }
}


@main
struct LogoGenerator {
    static func main() {
        print("Generating logo...")
        let home = URL(filePath: NSHomeDirectory())
        let fileURL = home.appendingPathComponent("logo.png")
        if let image = Logo().logo {
            do {
                try write(cgimage: image, to: fileURL)
                print("Done.")
            } catch {
                print("Logo not saved!")
            }
        }
    }
}
