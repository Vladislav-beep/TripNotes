//
//  mapViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 22.01.2022.
//

import Foundation
import MapKit

protocol MapViewModelProtocol {
    func showUserLocation() -> MKCoordinateRegion
    func getLocationManager(viewController: UIViewController)
    var locationService: LocationService { get }
}

class MapViewModel: MapViewModelProtocol {
    
    var locationService = LocationService()
    
    func showUserLocation() -> MKCoordinateRegion {
        print("25")
        return locationService.showUserLocation()
    }
    
    func getLocationManager(viewController: UIViewController) {
        locationService.locationManager.delegate = viewController as? CLLocationManagerDelegate
    }
}
