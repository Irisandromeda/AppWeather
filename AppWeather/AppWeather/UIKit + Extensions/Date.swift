//
//  Date.swift
//  AppWeather
//
//  Created by Irisandromeda on 30.11.2022.
//

import Foundation

extension Date {
    
    func getFormattedDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: self)
    }
    
}
