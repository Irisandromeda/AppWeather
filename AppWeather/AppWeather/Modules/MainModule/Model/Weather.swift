//
//  Weather.swift
//  AppWeather
//
//  Created by Irisandromeda on 28.11.2022.
//

import Foundation

//MARK: - Weather Model

struct WeatherData: Codable {
    var list: [List]
    let city: City
}

struct City: Codable {
    let name: String
}

struct List: Codable {
    let dt: Int
    let date: Date
    let main: Main
    let weather: [Weather]
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind
        case date = "dt_txt"
    }
}

struct Main: Codable {
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Weather: Codable {
    let id: Int
    let icon: String
}

struct Wind: Codable {
    let speed: Double
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            
            do {
                let decoder = newJSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.locale = Locale(identifier: "en_US")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let object = try decoder.decode(T.self, from: data)
                completionHandler(object,response,error)
            } catch (let decoderError) {
                completionHandler(nil,response,decoderError)
            }
        }
    }

    func weatherDataTask(with url: URL, completionHandler: @escaping (WeatherData?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

