//
//  UILabel.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, color: UIColor) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = color
    }
    
}
