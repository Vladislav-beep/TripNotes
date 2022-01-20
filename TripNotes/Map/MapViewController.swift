//
//  MapViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 20.01.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
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
        label.text = "Berlin, WeerStrasse 17"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapViewConstraints()
        setupCloseButtonConstraints()
        setupShowUserLocationButtonConstraints()
        setupOkButtonConstraints()
        setupAdressLabelConstraints()
    }
    
    @objc func closeScreen() {
        dismiss(animated: true)
    }
    
    @objc func showUserLocationButtonTapped() {
        
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
}
