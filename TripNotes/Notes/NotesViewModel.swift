//
//  NotesViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

protocol NotesViewModelProtocol {
    init(trip: Trip)
    var text: String { get }
}

class NotesViewModel: NotesViewModelProtocol {
    var text: String {
        trip.country
    }
    
    var trip: Trip
    
    required init(trip: Trip) {
        self.trip = trip
    }
}
