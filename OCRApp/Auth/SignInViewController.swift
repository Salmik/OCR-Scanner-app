//
//  SignInViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 09.06.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

final class SignInViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    func checkValid()-> String? {
        if nameTextField.text == "" ||
           passwordTextField.text == "" ||
           nameTextField.text == nil ||
           passwordTextField.text == nil { return "Please fill fields" }
           return nil
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
        if checkValid() != nil {
             createAlert(title: "Please fill fields", message: "You need fill all fields to sign in")
        } else {
            
            guard let email = self.nameTextField.text, let password = self.passwordTextField.text else {  return }
            guard Validators.isSimpleEmail(email) else { createAlert(title: "Wrong email", message: "Please write correct email")
                return
            }
            if password.count < 6 { createAlert(title: "Error", message: "Password must have more 6 characters") }
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, authError) in
                
                guard let self = self else {return}
                
                if authError != nil {
                    print(authError!.localizedDescription)
                } else {
                   //do something
                    self.performSegue(withIdentifier: "signin", sender: self)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    deinit {
        print("deinit!!! \(self)")
    }
}

 extension UIViewController {
    public func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
