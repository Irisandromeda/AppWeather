//
//  NetworkService.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

import Foundation

//MARK: - Network Service

protocol NetworkServiceProtocol {
    func getWeather(completion: @escaping (Result<WeatherData?, Error>) -> Void)
    func getWeatherByCity(city: String, completion: @escaping (Result<WeatherData?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getWeather(completion: @escaping (Result<WeatherData?, Error>) -> Void) {
        let urlString: String = "https://api.openweathermap.org/data/2.5/forecast?lat=50.450001&lon=30.523333&units=metric&lang=ua&appid=5bfc875a83a8bff99e61e3e034a18688"

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.weatherDataTask(with: url) { weatherData, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(weatherData))
        }.resume()
    }
    
    func getWeatherByCity(city: String, completion: @escaping (Result<WeatherData?, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&lang=ua&appid=5bfc875a83a8bff99e61e3e034a18688"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.weatherDataTask(with: url) { weatherData, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
        
            completion(.success(weatherData))
        }.resume()
    }
}
