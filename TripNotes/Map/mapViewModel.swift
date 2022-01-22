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
}

class MapViewModel: MapViewModelProtocol {
    
    let locationService = LocationService()
    
    func showUserLocation() -> MKCoordinateRegion {
        return locationService.showUserLocation()
    }
}
