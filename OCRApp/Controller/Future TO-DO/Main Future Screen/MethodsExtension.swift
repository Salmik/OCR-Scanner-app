//
//  MethodsExtension.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import LocalAuthentication

//MARK: - TouchId
extension FunctionsViewController {
    func authUser() {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Identify yourself"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [unowned self] (sucess, error) in
                
                DispatchQueue.main.async {
                    if sucess {
                        let ac = UIAlertController(title: "Did it", message: "Cool!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
    }
}

//MARK: - Default Alert
extension FunctionsViewController {
    func usualAlert() {
        let alert = UIAlertController(
            title: "Awesome!",
            message:  """
                      You are using SwiftEntryKit, \
                      and this is a customized alert \
                      view that is floating at the bottom.
                      """,
          preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Got it!", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert,animated: true,completion: nil)
    }
}
