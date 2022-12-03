//
//  UIImageView.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage, contentMode: ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
    
}
