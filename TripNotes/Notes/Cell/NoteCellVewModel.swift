//
//  NoteCelliewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 08.01.2022.
//

import Foundation

protocol NoteCellViewModelProtocol {
    var category: String { get }
    var city: String { get }
    var description: String { get }
    var date: String { get }
    var price: String { get }
    init(tripNote: TripNote, currency: String)
}

class NoteCellViewModel: NoteCellViewModelProtocol {
    
    // MARK: Properties
   
    var description: String {
        tripNote.description ?? ""
    }
    
    var date: String {
        "\(tripNote.date)"
    }
    
    var category: String {
        tripNote.category
    }
    
    var city: String {
        tripNote.city
    }
    
    var price: String {
        String(tripNote.price) + " " + currency
    }
    
    // MARK: Private properties
    
    private let tripNote: TripNote
    private let currency: String
    
    // MARK: Life Time
    
    required init(tripNote: TripNote, currency: String) {
        self.tripNote = tripNote
        self.currency = currency
    }
}
