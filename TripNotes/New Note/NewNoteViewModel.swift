//
//  NewNoteViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.01.2022.
//

import Foundation

protocol NewNoteViewModelProtocol {
    func printAA()
    func addNote(category: String, city: String, price: Double, isFavourite: Bool, description: String)
}

class NewNoteViewModel: NewNoteViewModelProtocol {
    
    let fire = FireBaseService()
    
    var trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
    }
    
    func printAA() {
        print("\(trip.id) - BBBBBBBB")
    }
    
    func addNote(category: String, city: String, price: Double, isFavourite: Bool, description: String) {
        fire.addNote(tripId: trip.id, category: category, city: city, price: price, isFavourite: isFavourite, description: description)
    }
    
}
