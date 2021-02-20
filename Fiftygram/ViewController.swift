//
//  ViewController.swift
//  Fiftygram
//
//  Created by Ritika Dhall on 08/10/20.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    let context = CIContext()
    var original: UIImage?
    
    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func savePhoto() {
        guard let image = imageView.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    @IBAction func applySepia() {
        guard let filter = CIFilter(name: "CISepiaTone") else {
            return
        }
        filter.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter: filter)
    }
    
    @IBAction func applyNoir() {
        guard let filter = CIFilter(name: "CIPhotoEffectNoir") else {
            return
        }
        display(filter: filter)
    }
    
    @IBAction func applyVintage() {
        guard let filter = CIFilter(name: "CIPhotoEffectProcess") else {
            return
        }
        display(filter: filter)
    }
    
    @IBAction func applyInvert() {
        guard let filter = CIFilter(name: "CIColorInvert") else {
            return
        }
        display(filter: filter)
    }
    
    @IBAction func applyChrome() {
        guard let filter = CIFilter(name: "CIPhotoEffectChrome") else {
            return
        }
        display(filter: filter)
    }
    
    @IBAction func applyFade() {
        guard let filter = CIFilter(name: "CIPhotoEffectFade") else {
            return
        }
        display(filter: filter)
    }
    
    @IBAction func applyInstant() {
        guard let filter = CIFilter(name: "CIPhotoEffectInstant") else {
            return
        }
        display(filter: filter)
    }
    
    func display(filter: CIFilter) {
        guard let original = original else {
            return
        }
        filter.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        guard let output = filter.outputImage else {
            return
        }
        guard let cgImage = self.context.createCGImage(output, from: output.extent) else {
            return
        }
        imageView.image = UIImage(cgImage: cgImage)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }
}

