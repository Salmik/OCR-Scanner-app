//
//  SwiftEntryKitExtension.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 08.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit
import SwiftEntryKit

// MARK: - SwiftEntryKit
extension FunctionsViewController {
    
    func swiftEntryKitFunc() {
        SwiftEntryKit.display(entry: MyPopView(with: setupMessage()), using: setupAttibutes())
    }
    
    func setupAttibutes() -> EKAttributes {
        var atrtibutes = EKAttributes.centerFloat
        atrtibutes.displayDuration = .infinity
        atrtibutes.screenBackground = .color(color: EKColor(light: UIColor(white: 100.0 / 255.0, alpha: 0.3), dark: UIColor(white: 50.0 / 255.0, alpha: 0.3)))
        atrtibutes.shadow = .active(with: EKAttributes.Shadow.Value(
            color: .black,
            opacity: 0.3,
            radius: 7))
        atrtibutes.screenInteraction = .dismiss
        atrtibutes.entryInteraction = .absorbTouches
        atrtibutes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt)
        atrtibutes.entranceAnimation = .init(
            translate: EKAttributes.Animation.Translate(
                duration: 0.7,
                spring: .init(damping: 1, initialVelocity: 0)),
            scale: .init(
                from: 1.05,
                to: 1,
                duration: 0.5,
                spring: .init(damping: 1, initialVelocity: 0)))
        atrtibutes.exitAnimation = .init(translate: .init(duration: 0.3))
        atrtibutes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3)))
        atrtibutes.statusBar = .dark
        atrtibutes.entryBackground = .color(color: .standardBackground)
        atrtibutes.roundCorners = .all(radius: 26)
        return atrtibutes
    }
    
    func setupMessage() -> EKPopUpMessage {
        let image = UIImage(named: "ic_done_all_dark_48pt")!.withRenderingMode(.alwaysTemplate)
        let title = "Awesome!"
        let description =
               """
               You are using SwiftEntryKit, \
               and this is a customized alert \
               view that is floating at the bottom.
               """
        let themeImage = EKPopUpMessage.ThemeImage(image: EKProperty.ImageContent(image: image, size: CGSize(width: 60, height: 60), tint: .black, contentMode: .scaleAspectFit))
        
        let titleLabel = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 24),
                                                                      color: .black,
                                                                      alignment: .center))
        
        let descriptionLabel = EKProperty.LabelContent(
            text: description,
            style: .init(
                font: UIFont.systemFont(ofSize: 16),
                color: .black,
                alignment: .center
            )
        )
        
        let button = EKProperty.ButtonContent(
            label: .init(
                text: "Got it!",
                style: .init(
                    font: UIFont.systemFont(ofSize: 16),
                    color: .black
                )
            ),
            backgroundColor: .init(UIColor.systemOrange),
            highlightedBackgroundColor: .clear
        )
        
        let message = EKPopUpMessage(themeImage: themeImage, title: titleLabel, description: descriptionLabel, button: button) {
            SwiftEntryKit.dismiss()
        }
        return message
    }
}
