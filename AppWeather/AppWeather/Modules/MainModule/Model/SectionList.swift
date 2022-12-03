//
//  SectionList.swift
//  AppWeather
//
//  Created by Irisandromeda on 03.12.2022.
//

import Foundation

enum SectionList {
    case weatherByHour(WeatherData)
    case weatherByDay(WeatherData)
    
    var items: WeatherData {
        switch self {
        case .weatherByHour(let items):
            return items
        case .weatherByDay(let items):
            return items
        }
    }
    
    var count: Int {
        return items.list.count
    }
}
