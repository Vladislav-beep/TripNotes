//
//  FavouritesViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 03.02.2022.
//

import Foundation

protocol FavouritesViewModelProtocol {
    func numberOfCells() -> Int
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    
    func numberOfCells() -> Int {
        20
    }
    
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol? {
        let note = getNotes()[indexPath.item]
        let currency = trip.currency
        return NoteCellViewModel(tripNote: note, currency: currency)
    }
}
