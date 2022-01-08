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
    func numberOfCells() -> Int
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol?
}

class NotesViewModel: NotesViewModelProtocol {
    var text: String {
        trip.country
    }
    
    var trip: Trip
    
    required init(trip: Trip) {
        self.trip = trip
    }
    
    func getNotes() -> [TripNote] {
        return trip.tripNotes
    }
    
    func numberOfCells() -> Int {
        trip.tripNotes.count
    }
    
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol? {
        let note = getNotes()[indexPath.item]
        let currency = trip.currency
        return NoteCellViewModel(tripNote: note, currency: currency)
    }
}
