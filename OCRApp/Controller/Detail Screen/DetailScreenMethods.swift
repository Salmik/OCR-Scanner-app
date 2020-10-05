//
//  DetailScreenMethods.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

extension ImageDetailViewController {
    
    //MARK:- Methods
       func setup() {
           let button1 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.exportButtonTapped))
           self.navigationItem.rightBarButtonItem = button1
           
           navigationItem.largeTitleDisplayMode = .never
           
           scrollView.minimumZoomScale = 1.0
           scrollView.maximumZoomScale = 10.0
           
           documents = Utilities.getDocuments()
           
           imageScrollView = ImageScrollView(frame: view.bounds)
           view.addSubview(imageScrollView)
//           imageScrollView.set(image: UIImage(contentsOfFile: documents[pictureOrderNumber].path)!)
           imageScrollView.set(image: UIImage(contentsOfFile: imageURL.path)!)

           // imageView.image = UIImage(contentsOfFile: documents[pictureOrderNumber].path)
//           sendResult = UIImage(contentsOfFile: documents[pictureOrderNumber].path)
           
           self.title = imageTitle
       }
    
    func showAlertWith(title: String, message: String){
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (UIAlertAction) in
            guard let self = self else {return}
            if let firstViewController = self.navigationController?.viewControllers.first {
                self.navigationController?.popToViewController(firstViewController, animated: true)
            }
        }))
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.present(ac, animated: true)
        }
    }
    
    func shareDocument(documentPath: String) {
        
        if FileManager.default.fileExists(atPath: documentPath){
            let fileURL = URL(fileURLWithPath: documentPath)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("Document was not found")
        }
    }
}
