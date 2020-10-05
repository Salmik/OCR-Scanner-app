//
//  MainScreenSaveMethods.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

extension MainViewController {
    
    func savePicture(picture: UIImage, imageName: String) {
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        let data = picture.jpegData(compressionQuality: 0.9)
        FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
    }
    
    func showSaveDialog(scannedImage: UIImage) {
        
        let now = Utilities.getTime()
        let alertController = UIAlertController(title: "Save Documents", message: "Enter document name", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Save", style: .default) { [weak self] (_) in
            
            guard let self = self else {return}
            
            let name = alertController.textFields?[0].text
            if name != "" {
                if Utilities.checkSameName(fileName: name!, documents: self.documents) {
                    self.savePicture(picture: scannedImage, imageName: "\(name!) (1).jpg")
                } else {
                    self.savePicture(picture: scannedImage, imageName: "\(name!).jpg")
                }
            } else {
                self.savePicture(picture: scannedImage, imageName: "\(now).jpg")
            }
            self.documents = Utilities.getDocuments()
            self.collectionView.reloadData()
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "\(now)"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        present(alertController, animated: true, completion: nil)
    }
    
}
