//
//  Instafilter.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-02.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct Instafilter: View {

    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?

    //@State private var currentFilter = CIFilter.sepiaTone()
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    @State private var showFilterSheet = false


    var body: some View {

        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)

                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)

                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    // select an image
                    showImagePicker = true
                }

                HStack {
                    Text("intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { newValue in
                            applyProcessing()
                        }
                }
                .padding(.vertical)

                HStack {
                    Button ("Change Filter") {
                        // change filter
                        showFilterSheet = true
                    }

                    Spacer()

                    Button("Save", action: save)
                        .disabled(image == nil ? true : false)
                }
            }
        }
        .padding([.horizontal, .bottom])
        .navigationTitle("Insta")
        .onChange(of: inputImage) { _ in
            loadImage()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .confirmationDialog("Select a filter", isPresented: $showFilterSheet) {
            // dialog here
            Button("Crystallize") { setFilter(CIFilter.crystallize()) }
            Button("Edges") { setFilter(CIFilter.edges()) }
            Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
            Button("Pixellate") { setFilter(CIFilter.pixellate()) }
            Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
            Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
            Button("Vignette") { setFilter(CIFilter.vignette()) }
            Button("Cancel", role: .cancel) { }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        //image = Image(uiImage: inputImage)

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func save() {
        guard let processedImage = processedImage else { return }
        let imageSaver = ImageSaver()

        imageSaver.successHandler = {
            print("Success")
        }

        imageSaver.errorHandler = { error in
            print ("Error = \(error.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }

    func applyProcessing() {

        //currentFilter.intensity = Float(filterIntensity)
        //currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)

        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }

        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }

        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct Instafilter_Previews: PreviewProvider {
    static var previews: some View {
        Instafilter()
    }
}
