//
//  ProfileViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 09.06.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

final class ProfileViewController: UIViewController {

    @IBOutlet weak var emailAuthButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailAuthButton.layer.cornerRadius = emailAuthButton.frame.size.height / 2
            
        Auth.auth().addStateDidChangeListener {[weak self] (auth, user) in
            guard self != nil else { return }
            if user != nil {
//                self.emailAuthButton.titleLabel?.text = "Sign Out"
            }
        }
    }
    
    @IBAction func emailAuthButtonPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
//            self.performSegue(withIdentifier: "out", sender: self)
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
