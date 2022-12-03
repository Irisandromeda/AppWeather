//
//  LocationService.swift
//  AppWeather
//
//  Created by Irisandromeda on 30.11.2022.
//

import UIKit
import CoreLocation

//MARK: - Location Service

protocol LocationServiceProtocol {
    var location: Location? { get set}
    func getCurrentLocation() -> Location?
}

class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    var delegate: LocationServiceProtocol?

    private let locationManager = CLLocationManager()
    var location: Location?

    override init() {
        super.init()

        didUpdateLocation()
    }

    func didUpdateLocation() {
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }

    func getCurrentLocation() -> Location? {
        return location
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationManager.stopUpdatingLocation()
            location = Location(latitude: lastLocation.coordinate.latitude.description,
                                longitude: lastLocation.coordinate.longitude.description)
        }
    }
}
