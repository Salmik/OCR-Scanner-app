//
//  SignUpViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 09.06.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

final class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    func checkValid() -> String? {
        if  nameTextFiled.text == "" ||
            emailTextFiled.text == "" ||
            passwordTextFiled.text == "" ||
            nameTextFiled.text == nil ||
            emailTextFiled.text == nil ||
            passwordTextFiled.text == nil
            { return "Please fill fields" }
           
        return nil
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let error = checkValid()
        
        if error != nil {
            createAlert(title: "Please fill fields", message: "You need fill all fields to sign up")
        } else {
            
            guard let email = self.emailTextFiled.text, let password = self.passwordTextFiled.text else {  return }
             guard Validators.isSimpleEmail(email) else { createAlert(title: "Wrong email", message: "Please write correct email")
                 return
             }
            
              if password.count < 6 { createAlert(title: "Error", message: "Password must have more 6 characters") }
            
            Auth.auth().createUser(withEmail: email, password: password) {[weak self] (result, error) in
                
                guard let self = self else {return}
                 
                if error != nil {
                    print(error?.localizedDescription ?? "Error \(self)")
                } else {
//                    let db = Firestore.firestore()
//                    db.collection("users").addDocument(data: [
//                        "email": self.emailTextFiled.text!,
//                        "name": self.nameTextFiled.text ?? "",
//                        "password": self.passwordTextFiled.text!,
//                        "uid": result!.user.uid
//                    ]) { (error) in
//                        if error != nil {
//                            print(error?.localizedDescription ?? "Error \(self)")
////                            fatalError("Can't add this user to database")
//
//                        }
//                    }
                    // do something
                    self.performSegue(withIdentifier: "signup", sender: self)
                }
            }
        } // else
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    deinit {
        print("deinit!!! \(self)")
    }
}
