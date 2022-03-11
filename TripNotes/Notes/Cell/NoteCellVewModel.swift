//
//  NoteCelliewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 08.01.2022.
//

import Foundation

protocol NoteCellViewModelProtocol {
    var id: String { get }
    var category: String { get }
    var city: String { get }
    var description: String { get }
    var date: String { get }
    var price: String { get }
    var isFavourite: Bool { get }
    init(tripNote: TripNote, currency: String, tripId: String)
    func deleteNote()
    func toggleFavourite(isFavourite: Bool)
    func getTripId() -> String
    func getNoteId() -> String
}

class NoteCellViewModel: NoteCellViewModelProtocol {
    
    let fire = FireBaseService()
    
    // MARK: Properties
    
    var id: String {
        tripNote.id
    }
   
    var description: String {
        tripNote.description ?? ""
    }
    
    var date: String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm, dd.MM.yy"
        
        let date = dateformatter.string(from: tripNote.date)
        return "\(date)"
    }
    
    var category: String {
        tripNote.category
    }
    
    var city: String {
        tripNote.city
    }
    
    var price: String {
        let formattedPrice = tripNote.price.formattedWithSeparator
        let returnPrice = "\(formattedPrice) \(currency)"
        return returnPrice
    }
    
    var isFavourite: Bool {
        tripNote.isFavourite
    }
    
    // MARK: Private properties
    
    private var tripNote: TripNote
    private let currency: String
    private let tripId: String
    
    // MARK: Life Time
    
    required init(tripNote: TripNote, currency: String, tripId: String) {
        self.tripNote = tripNote
        self.currency = currency
        self.tripId = tripId
    }
    
    // MARK: Methods
    
    func toggleFavourite(isFavourite: Bool) {
        fire.toggleFavourite(tripId: tripId, noteId: tripNote.id, isFavourite: isFavourite)
    }
    
    func deleteNote() {
        fire.deleteNote(tripId: tripId, noteId: tripNote.id)
    }
    
    func getTripId() -> String {
        return tripId
    }
    
    func getNoteId() -> String {
        return tripNote.id
    }
}
