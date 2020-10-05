//
//  ImageDetailViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 28.04.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import Vision

final class ImageDetailViewController: UIViewController {
    
    //MARK:- Properties
    var pictureOrderNumber = 0
    var documents = [URL]()
    var imageTitle = ""
    var sendResult: UIImage!
    var imageURL: URL!
    private var request: VNRecognizeTextRequest!
    var text = ""
    var imageScrollView: ImageScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK:- Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func exportButtonTapped() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            //            self.dismiss(animated: true) {}
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Share", style: .default, handler: {[weak self] action in
            //            self.dismiss(animated: true) {}
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.shareDocument(documentPath: self.documents[self.pictureOrderNumber].path)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "OCR", style: .default, handler: { [weak self] (action) in
            guard let self = self else { return }
            self.recognizeText(in: self.imageScrollView.imageZoomView.image!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Export to Photo Album", style: .default, handler: { [weak self] action in
            guard let self = self else {return}
            if let image = UIImage(contentsOfFile: self.documents[self.pictureOrderNumber].path) {
                MyAwesomeAlbum.shared.save(image: image)
                self.showAlertWith(title: "Saved!", message: "Your image has been saved to your Photo Album.")
            }
            //            self.dismiss(animated: true) {
            //            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self] _ in
            guard let self = self else {return}
            do {
                let filePath = self.documents[self.pictureOrderNumber]
                try FileManager.default.removeItem(at: filePath)
                
                if let firstViewController = self.navigationController?.viewControllers.first {
                    self.navigationController?.popToViewController(firstViewController, animated: true)
                }
            } catch {
                print("Delete error")
            }
        }))
        
        present(actionSheet, animated: true)
    }
    
    //MARK:- OCR
    lazy var workQueue = {
        return DispatchQueue(label: "workQueue", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    }()
    
    lazy var textRecognitionRequest: VNRecognizeTextRequest = {
        
        let req = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            var resultText = ""
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { return }
                resultText += topCandidate.string
                // resultText += "\n"
            }
            
            DispatchQueue.main.async { [weak self] in
                
                guard let self = self else {return}
                
                if !(resultText.isEmpty) {
                    self.text = resultText
                    self.performSegue(withIdentifier: "ocr", sender: nil)
                    
                }
                
            }
        }
        req.recognitionLanguages = ["en-US","ru-RU"]
        req.usesLanguageCorrection = true
        req.recognitionLevel = .accurate
        
        return req
    }()
    
    func recognizeText(in image: UIImage) {
        
        guard let cgImage = image.cgImage else { return }
        
        workQueue.async { [weak self] in
            guard let self = self else {return}
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try requestHandler.perform([self.textRecognitionRequest])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK:- Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ocr" {
            let dvc = segue.destination as! OCRViewController
            dvc.text = text
            dvc.imageTitle = imageTitle
        }
    }
}
