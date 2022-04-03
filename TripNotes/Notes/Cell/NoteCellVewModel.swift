//
//  NoteCelliewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 08.01.2022.
//

import Foundation

protocol NoteCellViewModelProtocol {
    var userId: String { get set }
    var id: String { get }
    var category: String { get }
    var city: String { get }
    var description: String { get }
    var date: String { get }
    var price: String { get }
    var isFavourite: Bool { get }
    var infoLabel: String { get }
    var isInfoShown: Bool { get }
    init(tripNote: TripNote, currency: String, trip: Trip, isInfoShown: Bool, fireBaseService: FireBaseServiceProtocol, dateFormatterService: DateFormatterServiceProtocol, userId: String)
    func deleteNote()
    func toggleFavourite(isFavourite: Bool)
    func getTripId() -> String
    func getNoteId() -> String
}

class NoteCellViewModel: NoteCellViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let fireBaseService: FireBaseServiceProtocol
    private let dateFormatterService: DateFormatterServiceProtocol
    
    // MARK: - Properties
    
    var userId: String
    
    var id: String {
        tripNote.id
    }
   
    var description: String {
        tripNote.description ?? ""
    }
    
    var date: String {
        "\(dateFormatterService.convertNoteDateToString(date: tripNote.date))"
    }
    
    var category: String {
        tripNote.category
    }
    
    var city: String {
        tripNote.city
    }
    
    var price: String {
        "\(tripNote.price.formattedWithSeparator) \(currency)"
    }
    
    var isFavourite: Bool {
        tripNote.isFavourite
    }
    
    var infoLabel: String {
        "\(trip.country) \n \(dateFormatterService.convertTripDateToShortString(date: trip.beginningDate)) - \(dateFormatterService.convertTripDateToShortString(date: trip.finishingDate))"
    }
    
    // MARK: - Private properties
    
    private var tripNote: TripNote
    private let currency: String
    private let trip: Trip
    
    // MARK: - Properties
    
    var isInfoShown: Bool
    
    // MARK: - Life Time
    
    required init(tripNote: TripNote,
                  currency: String,
                  trip: Trip,
                  isInfoShown: Bool,
                  fireBaseService: FireBaseServiceProtocol,
                  dateFormatterService: DateFormatterServiceProtocol,
                  userId: String) {
        self.tripNote = tripNote
        self.currency = currency
        self.trip = trip
        self.isInfoShown = isInfoShown
        self.fireBaseService = fireBaseService
        self.dateFormatterService = dateFormatterService
        self.userId = userId
    }
    
    // MARK: - Methods
    
    func toggleFavourite(isFavourite: Bool) {
        fireBaseService.toggleFavourite(forUser: userId, tripId: trip.id, noteId: tripNote.id, isFavourite: isFavourite)
    }
    
    func deleteNote() {
        fireBaseService.deleteNote(forUser: userId, tripId: trip.id, noteId: tripNote.id)
    }
    
    func getTripId() -> String {
        return trip.id
    }
    
    func getNoteId() -> String {
        return tripNote.id
    }
}
