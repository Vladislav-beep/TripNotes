//
//  TripsViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 16.12.2021.
//

import Foundation

protocol TripsViewModelProtocol {
    init(trip: Trip)
}

class TripsViewModel: TripsViewModelProtocol {
    private let trip: Trip
    
    required init(trip: Trip) {
        self.trip = trip
    }
    
    
}
