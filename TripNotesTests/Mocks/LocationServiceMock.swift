//
//  LocationServiceMock.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 22.05.2022.
//

import Foundation
import MapKit

class LocationServiceMock: LocationServiceProtocol {
    
    func setDelegates(for vc: Any) {}
    
    func requestLocation() {}
    
    func showUserLocation() -> MKCoordinateRegion? { return MKCoordinateRegion() }
}
