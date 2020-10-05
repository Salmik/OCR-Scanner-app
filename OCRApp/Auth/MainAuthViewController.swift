//
//  MainAuthViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 09.06.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

final class MainAuthViewController: UIViewController {

    @IBOutlet weak var imageBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener {[weak self] (auth, user) in
            
            guard let self = self else { return }
            
            if user != nil {
                self.performSegue(withIdentifier: "mainAuth", sender: self)
            }
            
            DispatchQueue.main.async { [weak self] in
                if Auth.auth().currentUser?.uid != nil {
                    guard let self = self else { return }
                    self.performSegue(withIdentifier: "mainAuth", sender: self)
                }
            }
        }
        blurSetup()
    }
    
    func blurSetup() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        imageBackground.image = UIImage(named: "image1")
        imageBackground.addSubview(blurEffectView)
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    deinit {
        print("deinit!!! \(self)")
    }
}
