//
//  CollectionView.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 10.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FunctionsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AdditionalCollectionViewCell
        
        let action = actions[indexPath.item]
        
        cell.layer.cornerRadius = 26
        cell.titleLabel.text = action.rawValue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let action = actions[indexPath.item]
        
        switch action {
        case .generateBarCode: performSegue(withIdentifier: "generateBar", sender: nil)
        case .generateQRCode: performSegue(withIdentifier: "generateQR", sender: nil)
        case .scanBarCode: performSegue(withIdentifier: "scanBar", sender: nil)
        case .scanQRCode: performSegue(withIdentifier: "scanQR", sender: nil)
        case .speechToText: performSegue(withIdentifier: "speech", sender: nil)
        case .touchID: authUser()
        case .rate: RateManager.showRateNow()
        case .notification: notification()
        case .questions: performSegue(withIdentifier: "questions", sender: nil)
        case .customAlert: swiftEntryKitFunc()
        case .usualAlert: usualAlert()
            
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FunctionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 50, height: 100)
    }
}

