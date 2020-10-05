//
//  SMSAuthViewController.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 10.06.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import Firebase
import FirebaseAuth

final class SMSAuthViewController: UIViewController {

    @IBOutlet weak var numberTextField: FPNTextField!
    @IBOutlet weak var fetchCodeButton: UIButton!
    
    var listController: FPNCountryListViewController!
    var phoneNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func fetchCodeButtonPressed(_ sender: UIButton) {
        
         guard phoneNumber != nil else { return }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) { [weak self] (verificationID, error) in
            
            guard let self = self else {return}
            
            if error != nil {
                print(error?.localizedDescription ?? "is empty")
            } else {
                self.goNextScreen(verificationID: verificationID!)
            }
            
        }
        
    }
    
    @IBAction func dissmissButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func goNextScreen(verificationID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(identifier: "CheckCodeViewController") as! CheckCodeViewController
        dvc.modalPresentationStyle = .fullScreen
        dvc.verificationID = verificationID
        self.present(dvc, animated: true, completion: nil)
    }
    
    func setup() {
        
        fetchCodeButton.alpha = 0.5
        fetchCodeButton.isEnabled = false
        
        numberTextField.displayMode = .list
        numberTextField.delegate = self
        
        listController = FPNCountryListViewController(style: .grouped)
        listController?.setup(repository: numberTextField.countryRepository)
        listController.didSelect = { country in
            self.numberTextField.setFlag(countryCode: country.code)
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

extension SMSAuthViewController: FPNTextFieldDelegate {
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        // TODO
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            
            fetchCodeButton.alpha = 1
            fetchCodeButton.isEnabled = true
            
            phoneNumber = textField.getFormattedPhoneNumber(format: .International)
        } else {
            fetchCodeButton.alpha = 0.5
            fetchCodeButton.isEnabled = false
        }
    }
    
    func fpnDisplayCountryList() {
        let navigationVC = UINavigationController(rootViewController: listController)
        listController.title = "Страны"
        numberTextField.text = ""
        self.present(navigationVC, animated: true, completion: nil)
    }
    
}
