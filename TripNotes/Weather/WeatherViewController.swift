//
//  WeatherViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 08.03.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: Dependencies
    
    private var viewModel: WeatherViewModelProtocol
    
    // MARK: UI
    
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
        cityLabel.text = "Berlin"
        cityLabel.textAlignment = .right
        cityLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "25 C"
        temperatureLabel.textColor = .tripBlue
        temperatureLabel.font = UIFont.systemFont(ofSize: 70, weight: .heavy)
        temperatureLabel.textAlignment = .center
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    private lazy var feelsLikeTemperatureLabel: UILabel = {
        let feelsLikeTemperatureLabel = UILabel()
        feelsLikeTemperatureLabel.text = "Feels like 23 C"
        feelsLikeTemperatureLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        feelsLikeTemperatureLabel.textAlignment = .right
        feelsLikeTemperatureLabel.textColor = .tripRed
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
    
    // MARK: Life Time
    
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
        view.backgroundColor = .white
    }
    
    // MARK: Actions
    
    @objc func closeScreen() {
        dismiss(animated: true)
    }
    
    // MARK: Private methods
    
    private func setupAllConstraints() {
        setupCityLabelConstraints()
        setupWeatherIconImageViewConstraints()
        setupTemperatureStackConstraints()
    }
    
    private func setupCityLabelConstraints() {
        view.addSubview(cityCloseStack)
        NSLayoutConstraint.activate([
            cityCloseStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            cityCloseStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityCloseStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cityCloseStack.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalTo: cityCloseStack.heightAnchor)
        ])
    }
    
    private func setupWeatherIconImageViewConstraints() {
        view.addSubview(weatherIconImageView)
        NSLayoutConstraint.activate([
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 170),
            weatherIconImageView.widthAnchor.constraint(equalTo: weatherIconImageView.heightAnchor),
            weatherIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            weatherIconImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupTemperatureStackConstraints() {
        view.addSubview(temperetureStack)
        NSLayoutConstraint.activate([
            temperetureStack.widthAnchor.constraint(equalTo: weatherIconImageView.widthAnchor),
            temperetureStack.heightAnchor.constraint(equalToConstant: 100),
            temperetureStack.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 10),
            temperetureStack.centerXAnchor.constraint(equalTo: weatherIconImageView.centerXAnchor, constant: 0)
        ])
    }
}
