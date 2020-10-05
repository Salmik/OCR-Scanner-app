//
//  MainScreenImagePicker.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

//MARK:- UIImagePickerControllerDelegate
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImageSourse(_ source: UIImagePickerController.SourceType) {

        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        DispatchQueue.main.async { [weak self] in
          guard let self = self else {return}
          guard let image = info[.editedImage] as? UIImage else { return print("OOPSSS")}
            self.showSaveDialog(scannedImage: image)
        }

        dismiss(animated: true, completion: nil)
    }
    
}
