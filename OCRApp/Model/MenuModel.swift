//
//  MenuModel.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 13.08.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

enum MenuModel: Int, CustomStringConvertible {
    
  case Profile
  case Menu
  case Contex
  case Settings
    
    var description: String{
        
        switch self {
        case .Profile: return "Profile"
        case .Menu: return "Menu"
        case .Contex: return "Contacts"
        case .Settings: return "Settings"
            
        }
    }
    
    var image: UIImage {
        
        switch self {
        case .Profile: return UIImage(named: "Profile") ?? UIImage()
        case .Menu: return UIImage(named: "Menu") ?? UIImage()
        case .Contex: return UIImage(named: "Contacts") ?? UIImage()
        case .Settings: return UIImage(named: "Settings") ?? UIImage()
            
        }

    }
}
