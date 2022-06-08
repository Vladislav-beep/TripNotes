//
//  WeatherViewModelTests.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 22.05.2022.
//

import XCTest

class WeatherViewModelTests: XCTestCase {
    
    // MARK: Private
    
    private var viewModel: WeatherViewModel!
    private var networkWeatherManagerMock: NetworkWeatherManagerMock!
    private var locationServiceMock: LocationServiceMock!
    
    
    // MARK: Lifecycle

    override func setUp() {
        super.setUp()
        networkWeatherManagerMock = NetworkWeatherManagerMock()
        locationServiceMock = LocationServiceMock()
        
        viewModel = .init(networkManager: networkWeatherManagerMock,
                          locationService: locationServiceMock)
    }

    override func tearDown() {
        viewModel = nil
        networkWeatherManagerMock = nil
        locationServiceMock = nil
        super.tearDown()
    }
    
    
    // MARK: TESTS

    func testFetchWeather() {        
        // Act
        viewModel.fetchWeather(longitude: 55.56, latitude: 55.78)
        
        // Assert
        XCTAssertEqual(viewModel.cityName, "Moscow")
        XCTAssertEqual(viewModel.IconName, "cloud.snow.fill")
        XCTAssertEqual(viewModel.feelsLikeTemperature, "Feels like 13 ℃")
        XCTAssertEqual(viewModel.temperature, "17 ℃")
    }
}
