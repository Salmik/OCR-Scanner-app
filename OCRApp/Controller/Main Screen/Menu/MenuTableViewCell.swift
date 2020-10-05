//
//  MenuTableViewCell.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 13.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

final class MenuTableCell: UITableViewCell {

    static let reuseId = "MenuTableCell"
    
    let iconImage: UIImageView = {
       let iv = UIImageView()
       iv.translatesAutoresizingMaskIntoConstraints = false
       iv.contentMode = .scaleAspectFit
       iv.clipsToBounds = true
       return iv
    }()
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Custom text"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconImage)
        addSubview(myLabel)
        
        backgroundColor = .clear
        
        //iconImage
        iconImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        //myLabel
        myLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

