//
//  ModulesBuilder.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

import UIKit

//MARK: - Models Builder

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createFindModule() -> UIViewController
}

class ModelsBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let locationService = LocationService()
        let presenter = MainPresenter(view: view, networkService: networkService, locationService: locationService)
        view.presenter = presenter
        return view
    }
    
    static func createFindModule() -> UIViewController {
        let view = FindViewController()
        let networkService = NetworkService()
        let presenter = FindPresenter(view: view, network: networkService)
        view.presenter = presenter
        return view
    }
}
