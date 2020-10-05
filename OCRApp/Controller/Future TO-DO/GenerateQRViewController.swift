//
//  GenerateQRViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 29.04.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

final class GenerateQRViewController: UIViewController {

    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func generateQRCodeButtonPressed(_ sender: UIButton) {
        guard let text = textFiled.text else { return }
        imageView.image = generateQRCode(from: text)
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

}
