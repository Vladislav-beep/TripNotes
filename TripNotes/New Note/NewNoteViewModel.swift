//
//  NewNoteViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.01.2022.
//

import Foundation

protocol NewNoteViewModelProtocol {
    
}

class NewNoteViewModel: NewNoteViewModelProtocol {
    
    let locationService = LocationService()
    
    func showUserLocation() {
        locationService.showUserLocation()
    }
}
