//
//  MapViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 20.01.2022.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewControllerDelegate {
    func getAddress(_ adress: String?)
}

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Dependencies
    
    private var viewModel: MapViewModelProtocol
    var mapViewControllerDelegate: MapViewControllerDelegate?
    
    // MARK: - UI
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = CloseButton()
        closeButton.tintColor =  .tripRed
        closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var showUserLocationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: C.ImageNames.showUserLocationButton.rawValue),
                                  for: .normal)
        button.tintColor = .tripRed
        button.addTarget(self, action: #selector(showUserLocationButtonTapped), for: .touchUpInside)
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tripRed
        button.setTitle(I.okButton, for: .normal)
        button.setTitleColor(.tripGrey, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.5
        button.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .tripBlue
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: C.ImageNames.mapPinImage.rawValue)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .tripRed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life Time
    
    init(viewModel: MapViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setDelegate(for: self)
        viewModel.requestLocation()
    }
    
    // MARK: - Actions
    
    @objc private func closeScreen() {
        dismiss(animated: true)
    }
    
    @objc private func showUserLocationButtonTapped() {
        showUserLocation()
    }
    
    @objc private func okButtonPressed() {
        mapViewControllerDelegate?.getAddress(adressLabel.text)
        dismiss(animated: true)
    }
    
    // MARK: - Private methods
    
    private func showUserLocation() {
        guard let region = viewModel.showUserLocation() else { return }
        mapView.setRegion(region, animated: true)
    }
    
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    // MARK: - Layout
    
    private func setupConstraints() {
        setupMapViewConstraints()
        setupCloseButtonConstraints()
        setupShowUserLocationButtonConstraints()
        setupOkButtonConstraints()
        setupAdressLabelConstraints()
        setupPinImageViewConstraints()
    }
    
    private func setupMapViewConstraints() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    private func setupCloseButtonConstraints() {
        mapView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            closeButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 36),
            closeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 15)
        ])
    }
    
    private func setupShowUserLocationButtonConstraints() {
        mapView.addSubview(showUserLocationButton)
        NSLayoutConstraint.activate([
            showUserLocationButton.heightAnchor.constraint(equalToConstant: 50),
            showUserLocationButton.widthAnchor.constraint(equalToConstant: 50),
            showUserLocationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor,
                                                             constant: -15),
            showUserLocationButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor,
                                                           constant: -UIScreen.main.bounds.height / 4)
        ])
    }
    
    private func setupOkButtonConstraints() {
        mapView.addSubview(okButton)
        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -30),
            okButton.heightAnchor.constraint(equalToConstant: 45),
            okButton.widthAnchor.constraint(equalToConstant: 120),
            okButton.centerXAnchor.constraint(equalTo: mapView.centerXAnchor, constant: 0)
        ])
    }
    
    private func setupAdressLabelConstraints() {
        mapView.addSubview(adressLabel)
        NSLayoutConstraint.activate([
            adressLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 30),
            adressLabel.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 15),
            adressLabel.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -15),
            adressLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupPinImageViewConstraints() {
        mapView.addSubview(pinImageView)
        NSLayoutConstraint.activate([
            pinImageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor, constant: 0),
            pinImageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -15),
            pinImageView.heightAnchor.constraint(equalToConstant: 40),
            pinImageView.widthAnchor.constraint(equalTo: pinImageView.heightAnchor)
        ])
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            self.showAlert(title: I.restrictedAlertTitle,
                           message: I.restrictedAlertMessage)
        case .denied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(title: I.deniedAlertTitle,
                               message: I.deniedAlertMessage)
            }
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            showUserLocation()
        @unknown default:
            print("New case is available")
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(center) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            let streetName = placemark?.thoroughfare
            let buildName = placemark?.subThoroughfare
            
            DispatchQueue.main.async {
                if streetName != nil && buildName != nil {
                    self.adressLabel.text = "\(streetName!), \(buildName!)"
                } else if streetName != nil {
                    self.adressLabel.text = "\(streetName ?? "")"
                } else {
                    self.adressLabel.text = ""
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        showUserLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(title: I.locationManagerErrorAlertTitle,
                  message: I.errorConnectionAlertMessage)
    }
}
