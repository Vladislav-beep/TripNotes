//
//  FavouritesViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 03.02.2022.
//

import Foundation

protocol FavouritesViewModelProtocol {
    func numberOfCells() -> Int
    init(fireBaseSrvice: FireBaseServiceProtocol, dateFormatterService:DateFormatterServiceProtocol,  userId: String)
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    
    let fireBaseSrvice: FireBaseServiceProtocol
    let dateFormatterService: DateFormatterServiceProtocol
    
    required init(fireBaseSrvice: FireBaseServiceProtocol, dateFormatterService:DateFormatterServiceProtocol, userId: String) {
        self.fireBaseSrvice = fireBaseSrvice
        self.dateFormatterService = dateFormatterService
        self.userId = userId
    }
    
    var userId: String
    
    var tripNotes: [TripNote]?
    
    func numberOfCells() -> Int {
        getNotes().count
    }
    
    func getNotes() -> [TripNote] {
        var notesArray: [TripNote] = []
//        for trip in getTrips() {
//            for note in trip.tripNotes {
//                if note.isFavourite {
//                    notesArray.append(note)
//                }
//            }
//        }
        return notesArray
    }
    
    func getCurrency() -> [String] {
        var currencyArray: [String] = []
        
//        for trip in getTrips() {
//            currencyArray.append(trip.currency)
//        }
        return currencyArray
    }
    
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol? {
        let note = getNotes()[indexPath.item]
        let currency = getCurrency()[indexPath.item]
        return NoteCellViewModel(tripNote: note, currency: currency, trip: Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: ""), isInfoShown: false, fireBaseService: fireBaseSrvice, dateFormatterService: dateFormatterService, userId: userId)
    }
}
