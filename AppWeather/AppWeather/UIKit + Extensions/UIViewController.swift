//
//  UIViewController.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okey", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
