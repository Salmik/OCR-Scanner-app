//
//  MyPopView.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 29.06.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import SwiftEntryKit

final class MyPopView: UIView {
    
    private var imageView: UIImageView!
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let actionButton = UIButton()
    
    private let message: EKPopUpMessage
    
    init(with message: EKPopUpMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func actionButtonPressed() {
        message.action()
    }
}

// MARK: - Setup View
extension MyPopView {
    func setupElements() {
        titleLabel.content = self.message.title
        descriptionLabel.content = self.message.description
        actionButton.buttonContent = self.message.button
        
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        
        guard let themeImage = message.themeImage else { return }
        imageView = UIImageView()
        imageView.imageContent = themeImage.image
    }
}

// MARK: - Setup Constraints
extension MyPopView {
    func setupConstraints() {
        
        addSubview(imageView)
        imageView.layoutToSuperview(.centerX)
        imageView.layoutToSuperview(.top, offset: 40)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        addSubview(descriptionLabel)
        descriptionLabel.layoutToSuperview(axis: .horizontally, offset: 30)
        descriptionLabel.layout(.top, to: .bottom, of: titleLabel, offset: 16)
        descriptionLabel.forceContentWrap(.vertically)
        
        addSubview(actionButton)
        let height: CGFloat = 45
        actionButton.set(.height, of: height)
        actionButton.layout(.top, to: .bottom, of: descriptionLabel, offset: 30)
        actionButton.layoutToSuperview(.bottom, offset: -30)
        actionButton.layoutToSuperview(.centerX)
        
        let buttonAttributes = message.button
        actionButton.buttonContent = buttonAttributes
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        actionButton.layer.cornerRadius = height * 0.5
    }
}
