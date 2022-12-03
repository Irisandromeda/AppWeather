//
//  FindPresenter.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

import Foundation

//MARK: - Input

protocol FindViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

//MARK: - Output

protocol FindViewPresenterProtocol: AnyObject {
    init(view: FindViewProtocol, network: NetworkService)
    func getWeatherByCity(city: String)
    var weather: WeatherData? { get set }
}

//MARK: - Presenter

class FindPresenter: FindViewPresenterProtocol {
    weak var view: FindViewProtocol?
    let networkService: NetworkServiceProtocol!
    var weather: WeatherData?
    
    required init(view: FindViewProtocol, network: NetworkService) {
        self.view = view
        self.networkService = network
    }
    
    func getWeatherByCity(city: String) {
        networkService.getWeatherByCity(city: city) { [weak self] result in
            guard self != nil else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.weather = weather
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
}
