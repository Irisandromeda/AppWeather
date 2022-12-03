//
//  MainPresenter.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

import Foundation

//MARK: - Input

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
    func updateWeatherInfo()
}

//MARK: - Output

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol)
    func getWeather()
    var weather: WeatherData? { get set }
    func sortWeatherByHours(weather: WeatherData?)
    var weatherByHours: WeatherData? { get set }
    func sortWeatherByDays(weather: WeatherData?)
    var weatherByDays: WeatherData? { get set }
    var pageData: [SectionList]? { get set }
    func fillPageData(weather: WeatherData?, currentWeatherDay: WeatherData?)
}

//MARK: - Presenter

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    let locationService: LocationServiceProtocol!
    var weather: WeatherData?
    var weatherByHours: WeatherData?
    var weatherByDays: WeatherData?
    var pageData: [SectionList]?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.locationService = locationService
        getWeather()
    }
    
    func getWeather() {
        networkService.getWeather() { [weak self] result in
            guard self != nil else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.weather = weather
                    self?.sortWeatherByHours(weather: weather)
//                    self?.sortWeatherByDays(weather: weather)
                    self?.fillPageData(weather: weather, currentWeatherDay: self?.weatherByHours)
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    
    func sortWeatherByHours(weather: WeatherData?) {
        guard let list = weather?.list else { return }
        var weatherByHours: WeatherData = WeatherData(list: [], city: City(name: ""))
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = formatter.string(from: date)
        
        for data in list {
            let dateString = formatter.string(from: data.date)
            if dateString == currentDateString {
                weatherByHours.list.append(data)
            }
            self.weatherByHours = weatherByHours
        }
    }
    
    func sortWeatherByDays(weather: WeatherData?) {
//        guard let list = weather?.list else { return }
//        var weatherByDays: WeatherData = WeatherData(list: [], city: City(name: ""))
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm:ss"
//
//        for data in list {
//            let dataString = formatter.string(from: data.date)
//            if dataString == "20:00:00"{
//                weatherByDays.list.append(data)
//            }
//            self.weatherByDays = weatherByDays
//        }
    }
    
    func fillPageData(weather: WeatherData?, currentWeatherDay: WeatherData?) {
        let weatherByHour: SectionList = {
            .weatherByHour(currentWeatherDay!)
        }()

        let weatherByDay: SectionList = {
            .weatherByDay(weather!)
        }()
        
        pageData = [weatherByHour,weatherByDay]
    }
}
