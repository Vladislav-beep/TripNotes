//
//  mapViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 22.01.2022.
//

import Foundation
import MapKit

protocol MapViewModelProtocol {
    init(locationService: LocationServiceProtocol)
    func setDelegate(for vc: Any)
    func requestLocation()
    func showUserLocation() -> MKCoordinateRegion?
}

class MapViewModel: MapViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let locationService: LocationServiceProtocol
    
    // MARK: - Life Time
    
    required init(locationService: LocationServiceProtocol) {
        self.locationService = locationService
    }
    
    // MARK: - Methods
    
    func setDelegate(for vc: Any) {
        locationService.setDelegates(for: vc)
    }
    
    func requestLocation() {
        locationService.requestLocation()
    }
    
    func showUserLocation() -> MKCoordinateRegion? {
        locationService.showUserLocation()
    }
}
