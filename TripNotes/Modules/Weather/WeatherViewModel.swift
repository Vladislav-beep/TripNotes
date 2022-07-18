//
//  WeatherViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 08.03.2022.
//

import Foundation
import CoreLocation

protocol WeatherViewModelProtocol {
    var cityName: String { get }
    var temperature: String { get }
    var feelsLikeTemperature: String { get }
    var IconName: String { get }
    var weatherCompletion: (() -> Void)? { get set }
    var errorCompletion: ((String) -> Void)? { get set }
    init(networkManager: NetworkWeatherManagerProtocol, locationService: LocationServiceProtocol)
    func fetchWeather(longitude: CLLocationDegrees, latitude: CLLocationDegrees)
    func setDelegate(for vc: Any)
    func requestLocation()
}

class WeatherViewModel: WeatherViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let networkManager: NetworkWeatherManagerProtocol
    private let locationService: LocationServiceProtocol
    
    // MARK: - Private properties
    
    private var weather: CurrentWeather?
    
    // MARK: - Properties
    
    var weatherCompletion: (() -> Void)?
    var errorCompletion: ((String) -> Void)?
    
    var cityName: String {
        weather?.cityName ?? ""
    }
    
    var temperature: String {
        let temp = weather?.temperatureString ?? ""
        return "\(temp) ℃"
    }
    
    var feelsLikeTemperature: String {
        let fellsLikeTemp = weather?.feelsLikeTemperatureString ?? ""
        return "Feels like \(fellsLikeTemp) ℃"
    }
    
    var IconName: String {
        weather?.systemIconNameString ?? C.ImageNames.cloud.rawValue
    }
    
    // MARK: - Life Time
    
    required init(networkManager: NetworkWeatherManagerProtocol,
                  locationService: LocationServiceProtocol) {
        self.networkManager = networkManager
        self.locationService = locationService
    }
    
    // MARK: - Methods
    
    func fetchWeather(longitude: CLLocationDegrees, latitude: CLLocationDegrees) {
        networkManager.fetchCurrentWeather(forCoordinates: longitude, latitude: latitude) { [weak self] (result: Result<CurrentWeather, NetworkError>) in
            switch result {
            case .success(let weather):
                self?.weather = weather
                self?.weatherCompletion?()
            case .failure(let error):
                self?.errorCompletion?(error.errorDescription ?? "")
                print(error.localizedDescription)
            }
        }
    }
    
    func setDelegate(for vc: Any) {
        locationService.setDelegates(for: vc)
    }
    
    func requestLocation() {
        locationService.requestLocation()
    }
}
