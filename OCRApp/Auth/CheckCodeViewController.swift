//
//  CheckCodeViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 10.06.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

final class CheckCodeViewController: UIViewController {
    
    var verificationID: String!
    
    @IBOutlet weak var checkCodeButton: UIButton!
    @IBOutlet weak var codeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        checkCodeButton.alpha = 0.5
        checkCodeButton.isEnabled = false
        
        codeTextView.delegate = self
        codeTextView.becomeFirstResponder()
    }

    @IBAction func checkCodeButtonTapped(_ sender: UIButton) {
        
        guard let codeText = codeTextView.text else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: codeText)
        
        Auth.auth().signIn(with: credential) { (_, error) in
            if error != nil {
                self.showAlert(title: "Invalid code!", text: "The SMS verification code used to create the phone auth credential is invalid. Please resend the verification code SMS and be sure to use the verification code provided by the user")
                print(error?.localizedDescription ?? "It's imposibble :)")
            } else {
                self.performSegue(withIdentifier: "phoneAuth", sender: self)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func showAlert(title: String, text: String) {
         let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
         let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         
         alert.addAction(cancel)
         
         present(alert, animated: true, completion: nil)
     }
    
    deinit {
        print("deinit!!! \(self)")
    }
}

extension CheckCodeViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        let newlengh = currentCharacterCount + text.count - range.length
        return newlengh <= 6
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 6 {
            checkCodeButton.alpha = 1
            checkCodeButton.isEnabled = true
        } else {
            checkCodeButton.alpha = 0.5
            checkCodeButton.isEnabled = false
        }
    }
    
}
