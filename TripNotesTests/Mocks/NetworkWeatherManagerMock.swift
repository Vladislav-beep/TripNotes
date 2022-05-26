//
//  NetworkWeatherManagerMock.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 22.05.2022.
//

import Foundation
import CoreLocation

class NetworkWeatherManagerMock: NetworkWeatherManagerProtocol {
    
    private let main = Main(temp: 17, feelsLike: 13)
    private let weather = Weather(id: 600)
    private lazy var currentWeatherData = CurrentWeatherData(name: "Moscow",
                                                             main: main,
                                                             weather: [weather])
    private lazy var currentWeather = CurrentWeather(currentWeatherData: currentWeatherData)
    
    
    func fetchCurrentWeather(forCoordinates longitude: CLLocationDegrees, latitude: CLLocationDegrees, comletion: @escaping (Result<CurrentWeather, NetworkError>) -> Void) {
        comletion(.success(currentWeather!))
    }
}
