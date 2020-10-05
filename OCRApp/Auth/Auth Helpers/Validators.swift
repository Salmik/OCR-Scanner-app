//
//  Validators.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 16.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import Foundation

final class Validators {
    
    static func isFilled(firstname: String?, lastName: String?, email: String?, password: String?) -> Bool {
        guard !(firstname ?? "").isEmpty,
            !(lastName ?? "").isEmpty,
            !(email ?? "").isEmpty,
            !(password ?? "").isEmpty else {
                return false
        }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
