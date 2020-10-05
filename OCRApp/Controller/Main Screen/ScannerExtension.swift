//
//  MainScreenScannerExtension.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import WeScan

//MARK:- ImageScannerControllerDelegate
extension MainViewController: ImageScannerControllerDelegate {
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        
        if results.doesUserPreferEnhancedScan {
            scannedImage = results.enhancedScan?.image
        } else {
            scannedImage = results.croppedScan.image
        }
        scanner.dismiss(animated: true, completion: nil)
        showSaveDialog(scannedImage: scannedImage)
    }
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scanner.dismiss(animated: true, completion: nil)
    }
    
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

//MARK:- VNDocumentCameraViewControllerDelegate
//extension ViewController: VNDocumentCameraViewControllerDelegate {
//
//    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//
//    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//
//    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
//
//        DispatchQueue.main.async {[weak self] in
//            guard let self = self else {return}
//            let img = scan.imageOfPage(at: 0)
//            self.showSaveDialog(scannedImage: img)
//        }
//
//        controller.dismiss(animated: true, completion: nil)
//
//    }
//
//}
