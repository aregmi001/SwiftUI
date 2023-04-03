//
//  ImagePicker.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-03.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var image: UIImage?

    class Coordinator : NSObject, PHPickerViewControllerDelegate {

        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

            // Tell the picker to go away
            picker.dismiss(animated: true)

            // Exit if no selection was made
            guard let provider = results.first?.itemProvider else { return }

            // If this has an image we can use, use it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }

    // type below line before you auto generate the stubs
    // typealias UIViewControllerType = PHPickerViewController

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

