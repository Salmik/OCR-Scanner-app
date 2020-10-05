//
//  FutureModel.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

 enum Actions: String, CaseIterable {
    case generateQRCode = "Generate QrCode"
    case generateBarCode = "Generate BarCode"
    case scanQRCode = "Scan QRCode"
    case scanBarCode = "Scan BarCode"
    case speechToText = "Speech recognizer"
    case touchID = "Touch ID"
    case rate = "Rate us"
    case notification = "Local Notification"
    case questions = "Questions"
    case customAlert = "Custom Alert"
    case usualAlert = "Default Alert"
}
