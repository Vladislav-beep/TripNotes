//
//  MapViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 20.01.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let mapManager = LocationService()
    
    var viewModel: MapViewModelProtocol?
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .tripRed
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var showUserLocationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "location.circle"), for: .normal)
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
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.tripGrey, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .tripRed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  mapManager.locationManager.delegate = self
        viewModel?.locationService.locationManager.delegate = self
        
        showUserLocation()
     //   checkLocationServices()
        setupConstraints() 
    }
    
    private func setupConstraints() {
        setupMapViewConstraints()
        setupCloseButtonConstraints()
        setupShowUserLocationButtonConstraints()
        setupOkButtonConstraints()
        setupAdressLabelConstraints()
        setupPinImageViewConstraints()
    }
    
//    private func checkLocationServices() {
//        mapManager.checkLocationServices(mapView: mapView) {
//            mapManager.locationManager.delegate = self
//        }
//    }
    
    @objc func closeScreen() {
        dismiss(animated: true)
    }
    
    @objc func showUserLocationButtonTapped() {
        showUserLocation()
    }
    
    private func showUserLocation() {
      //  mapManager.showUserLocation2(mapView: mapView)
        let region = viewModel?.showUserLocation()
        print("37")
        guard let unwrappedRegion = region else { return }

        mapView.setRegion(unwrappedRegion, animated: true)
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
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 30),
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

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("2")
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            self.showAlert(title: "Your location is restricted",
                           message: "To give permission go to: Settings -> My Places -> Location")
        case .denied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(title: "Your location is not available",
                               message: "To give permission go to: Settings -> My Places -> Location")
            }
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            showUserLocation()
        @unknown default:
            print("New case is available")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true)
    }
}
