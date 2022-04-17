//
//  LocationSevice.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 22.01.2022.
//

import Foundation
import MapKit

protocol LocationServiceProtocol {
    func setDelegates(for vc: Any)
    func requestLocation()
    func showUserLocation() -> MKCoordinateRegion?
}

class LocationService: LocationServiceProtocol {
    
    // MARK: - Private properties
    
    private lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    // MARK: - Methods
    
    func setDelegates(for vc: Any) {
        locationManager.delegate = vc as? CLLocationManagerDelegate
    }
    
    func requestLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    func showUserLocation() -> MKCoordinateRegion? {
        guard let location = locationManager.location?.coordinate else { return nil }
        let region = MKCoordinateRegion(center: location,
                                        latitudinalMeters: 500,
                                        longitudinalMeters: 500)
        return region
    }
}
