//
//  MainScreenNavigationCustomize.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

//MARK: - Set title with image for navigation
extension MainViewController {
    func setTitle(_ title: String, andImage image: UIImage) {
        
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        
        let imageView = UIImageView(image: image)
        let titleView = UIStackView(arrangedSubviews: [imageView, titleLbl])
        titleView.axis = .horizontal
        titleView.spacing = 7.5
        
        navigationItem.titleView = titleView
    }
    
}
