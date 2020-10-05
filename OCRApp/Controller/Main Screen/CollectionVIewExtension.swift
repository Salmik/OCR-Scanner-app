//
//  MainScreenCollevtionVIewExtension.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltered {
            return filteredDocuments.count
        } else {
            return documents.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainImageCollectionViewCell
        
        var documentss = [URL]()
        
        if isFiltered {
            documentss = filteredDocuments
        } else {
            documentss = documents
        }
        
        let documentPath = documentss[indexPath.row].path
        let documentExtensition = documentPath.suffix(3)
        let title = documentPath.components(separatedBy: "Documents/")[1]
        
        cell.titleLabel.text = String(Array(title)[0..<(title.count-4)])
        cell.layer.cornerRadius = 9
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        
        if documentExtensition == "jpg" {
            cell.imageView.image = UIImage(contentsOfFile: documentPath)
            cell.documentType.text = "JPG"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let documentExtensition = documents[indexPath.row].path.suffix(3)
        documentOrderNumber = indexPath.row
        if documentExtensition == "jpg" {
            performSegue(withIdentifier: "imageDetail", sender: nil)
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0)
    }
    
}
