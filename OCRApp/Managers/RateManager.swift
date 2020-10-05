//
//  RateManager.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 28.04.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import Foundation
import StoreKit

@available(iOS 11, *)
final class RateManager {

    class func incrementCount() {
       let count = UserDefaults.standard.integer(forKey: "run_count")
        if count < 3 {
            UserDefaults.standard.set(count + 1, forKey: "run_count")
            UserDefaults.standard.synchronize()
        }
    }

    class func showRate() {
        let count = UserDefaults.standard.integer(forKey: "run_count")
        if  count == 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
    class func showRateNow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            SKStoreReviewController.requestReview()
        }
    }
}
