//
//  NotesViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

protocol NotesViewModelProtocol {
    init(trip: Trip?)
    var text: String { get }
    func numberOfCells() -> Int
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol?
}

class NotesViewModel: NotesViewModelProtocol {
    
    // MARK: Properties
    
    var text: String {
        trip?.country ?? ""
    }
    
    var trip: Trip?
    
    // MARK: Life time
    
    required init(trip: Trip?) {
        self.trip = trip
    }
    
    // MARK: Methods
    
    func getNotes() -> [TripNote] {
        return trip?.tripNotes ?? []
    }
    
    func numberOfCells() -> Int {
        trip?.tripNotes.count ?? 0
    }
    
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol? {
        let note = getNotes()[indexPath.item]
        let currency = trip?.currency ?? .dollar
        return NoteCellViewModel(tripNote: note, currency: currency)
    }
}
