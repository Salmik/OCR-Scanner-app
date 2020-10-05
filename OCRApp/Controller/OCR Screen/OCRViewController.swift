//
//  OCRViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 28.04.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

final class OCRViewController: UIViewController {
    
    @IBOutlet weak var ocrTextResult: UITextView!
    @IBOutlet weak var bottomOcrConstraint: NSLayoutConstraint!
    
    var text = ""
    var imageTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ocrTextResult.text = text
        
        title = imageTitle
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func actionsWithOcrResult(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Choose action's", message: "Type what actions you want to do", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { [weak self] (_) in
            guard let self = self else { return }
            let text = self.ocrTextResult.text
            let paste = UIPasteboard.general
            paste.string = text
            
            self.showAlert(title: "Copied", text: "your text was successfully copied")
        }))
        
        alert.addAction(UIAlertAction(title: "Translate", style: .default, handler: { (_) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        self.ocrTextResult.resignFirstResponder()
    }
    
    @objc func updateTextView(notification: Notification) {
        
        guard let userinfo = notification.userInfo as? [String:AnyObject],
            let keyboardFrame = (userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            ocrTextResult.contentInset = UIEdgeInsets.zero
        } else {
            ocrTextResult.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height - bottomOcrConstraint.constant, right: 0)
            ocrTextResult.scrollIndicatorInsets = ocrTextResult.contentInset
        }
        
        ocrTextResult.scrollRangeToVisible(ocrTextResult.selectedRange)
    }
    
}

extension OCRViewController {
    
    func showAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
}
