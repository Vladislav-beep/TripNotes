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
    init(networkManager: NetworkWeatherManagerProtocol)
    func fetchWeather(longitude: CLLocationDegrees, latitude: CLLocationDegrees)
}

class WeatherViewModel: WeatherViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let networkManager: NetworkWeatherManagerProtocol
    
    // MARK: - Properties
    
    var weather: CurrentWeather?
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
        weather?.systemIconNameString ?? "cloud"
    }
    
    // MARK: - Life Time
    
    required init(networkManager: NetworkWeatherManagerProtocol) {
        self.networkManager = networkManager
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
}

