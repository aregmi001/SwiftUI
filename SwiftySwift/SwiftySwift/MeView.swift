//
//  MeView.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-06.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import UserNotifications

struct MeView: View {

    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    @State private var qrCode = UIImage()

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)

                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            // save my code
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)

                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
        }
        .navigationTitle("Your Code")
        .onAppear(perform: updateCode)
        .onChange(of: name) { _ in updateCode() }
        .onChange(of: emailAddress) { _ in updateCode() }
    }

    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }

    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {

                qrCode = UIImage(cgImage: cgImage)

                return qrCode
            }
        }

        return UIImage(systemName: "xmar.circle") ?? UIImage()
    }    
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
