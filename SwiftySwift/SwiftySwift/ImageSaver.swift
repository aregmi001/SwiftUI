//
//  ImageSaver.swift
//  SwiftySwift
//
//  Created by Amit on 2023-04-03.
//

import Foundation
import UIKit

class ImageSaver: NSObject {

    var successHandler : (() -> Void)?
    var errorHandler : ((Error) -> Void)?


    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print ("Save Finished")

        if  let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
