//
//  NetworkWeatherManager.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 09.03.2022.
//

import Foundation
import CoreLocation

protocol NetworkWeatherManagerProtocol {
    func fetchCurrentWeather(forCoordinates longitude: CLLocationDegrees, latitude: CLLocationDegrees, comletion: @escaping (Result<CurrentWeather, NetworkError>) -> Void)
}

class NetworkWeatherManager: NetworkWeatherManagerProtocol {
    
    // MARK: - Methods
    
    func fetchCurrentWeather(forCoordinates longitude: CLLocationDegrees, latitude: CLLocationDegrees, comletion: @escaping (Result<CurrentWeather, NetworkError>) -> Void) {
        let apiKey = Constants.ApiKeys.weatherKey.rawValue
        let urlString = Constants.URLs.weatherURL.rawValue + "lat=\(latitude)&lon=\(longitude)&apikey=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            comletion(.failure(NetworkError.badURL))
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                comletion(.failure(NetworkError.networkProblem))
                return
            }
            
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    comletion(.success(currentWeather))
                } else {
                    comletion(.failure(NetworkError.badData))
                }
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
            print("1234")
        }
        return nil
    }
}
