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
    
    var tripNotes: [TripNote]?
    
    func numberOfCells() -> Int {
        getNotes().count
    }
    
    func getTrips() -> [Trip] {
        return Trip.getData()
    }
    
//    func getNotes() -> [TripNote: Currency] {
//        var notesArray: [TripNote: Currency] = [:]
//        var currency: Currency
//        for trip in getTrips() {
//            currency = trip.currency
//            for note in trip.tripNotes {
//                if note.isFavoutite == true {
//                    notesArray[note] = currency
//                }
//            }
//        }
//    }
    
    func getNotes() -> [TripNote] {
        var notesArray: [TripNote] = []
        for trip in getTrips() {
            for note in trip.tripNotes {
                if note.isFavoutite {
                    notesArray.append(note)
                }
            }
        }
        return notesArray
    }
    
    func getCurrency() -> [Currency] {
        var currencyArray: [Currency] = []
        
        for trip in getTrips() {
            currencyArray.append(trip.currency)
        }
        return currencyArray
    }
    
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol? {
        let note = getNotes()[indexPath.item]
        let currency = getCurrency()[indexPath.item]
        return NoteCellViewModel(tripNote: note, currency: currency)
    }
}
