//
//  WeatherViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 08.03.2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: WeatherViewModelProtocol
    
    // MARK: - UI
    
    private lazy var weatherIconImageView: UIImageView = {
        let weatherIconImageView = UIImageView()
        weatherIconImageView.image = UIImage(systemName: "cloud")
        weatherIconImageView.contentMode = .scaleAspectFit
        weatherIconImageView.tintColor = .tripBlue
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        return weatherIconImageView
    }()
    
    private lazy var closeButton: CloseButton = {
        let closeButton = CloseButton()
        closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.textAlignment = .right
        cityLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.textColor = .tripBlue
        temperatureLabel.font = UIFont.systemFont(ofSize: 70, weight: .heavy)
        temperatureLabel.textAlignment = .center
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    private lazy var feelsLikeTemperatureLabel: UILabel = {
        let feelsLikeTemperatureLabel = UILabel()
        feelsLikeTemperatureLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        feelsLikeTemperatureLabel.textAlignment = .right
        feelsLikeTemperatureLabel.textColor = .tripRed
        feelsLikeTemperatureLabel.adjustsFontSizeToFitWidth = true
        feelsLikeTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return feelsLikeTemperatureLabel
    }()
    
    private lazy var cityCloseStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [closeButton, cityLabel],
                                axis: .horizontal,
                                spacing: 10,
                                distribution: .fillProportionally)
        return stack
    }()
    
    private lazy var temperetureStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [temperatureLabel, feelsLikeTemperatureLabel],
                                axis: .vertical,
                                spacing: 8,
                                distribution: .fillProportionally)
        return stack
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    // MARK: - Life Time
    
    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tripGrey
        view.layer.cornerRadius = 30
        activityIndicator.startAnimating()
        
        setupViewModelBindings()
        viewModel.setDelegate(for: self)
        viewModel.requestLocation()
    }
    
    // MARK: - Actions
    
    @objc private func closeScreen() {
        dismiss(animated: true)
    }
    
    let location = LocationService()
    
    // MARK: - Private methods
    
    private func requestLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    private func setupViewModelBindings() {
        viewModel.weatherCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.cityLabel.text = self?.viewModel.cityName
                self?.temperatureLabel.text = self?.viewModel.temperature
                self?.feelsLikeTemperatureLabel.text = self?.viewModel.feelsLikeTemperature
                self?.weatherIconImageView.image = UIImage(systemName: self?.viewModel.IconName ?? "cloud")
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        }
  
        viewModel.errorCompletion = { [weak self] error in
            DispatchQueue.main.async {
                self?.dismiss(animated: true)
                self?.showAlert(title: "Network error", message: error.description)
            }
        }
    }
    
    // MARK: - Layout
    
    private func setupAllConstraints() {
        setupCloseButtonConstraints()
        setupCityLabelConstraints()
        setupWeatherIconImageViewConstraints()
        setupTemperatureStackConstraints()
        setupActivityIndicatorConstraints()
    }
    
    private func setupCloseButtonConstraints() {
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupCityLabelConstraints() {
        view.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor, constant: 0),
            cityLabel.heightAnchor.constraint(equalToConstant: 40),
            cityLabel.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 10),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupWeatherIconImageViewConstraints() {
        view.addSubview(weatherIconImageView)
        NSLayoutConstraint.activate([
            weatherIconImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.21),
            weatherIconImageView.widthAnchor.constraint(equalTo: weatherIconImageView.heightAnchor),
            weatherIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            weatherIconImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupTemperatureStackConstraints() {
        view.addSubview(temperetureStack)
        NSLayoutConstraint.activate([
            temperetureStack.widthAnchor.constraint(equalTo: weatherIconImageView.widthAnchor),
            temperetureStack.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.12),
            temperetureStack.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 10),
            temperetureStack.centerXAnchor.constraint(equalTo: weatherIconImageView.centerXAnchor, constant: 0)
        ])
    }
    
    private func setupActivityIndicatorConstraints() {
        weatherIconImageView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: weatherIconImageView.centerYAnchor, constant: 0),
            activityIndicator.centerXAnchor.constraint(equalTo: weatherIconImageView.centerXAnchor, constant: 0)
        ])
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        viewModel.fetchWeather(longitude: longitude, latitude: latitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(title: "Coudn't determine your location",
                  message: "Please, check your internet connection")
    }
}
