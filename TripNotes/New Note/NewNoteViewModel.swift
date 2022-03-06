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
    func updateNote(city: String, category: String, description: String, price: Double)
    func downloadNote()
    var noteCompletion: (() -> Void)? { get set }
    var category: String { get }
    var city: String { get }
    var price: String { get }
    var description: String { get }
    init(tripId: String, noteId: String)
}

class NewNoteViewModel: NewNoteViewModelProtocol {
    
    
    
    let fire = FireBaseService()
    
    //var trip: Trip
    var tripId: String
    var note: TripNote?
    var noteId: String
    var noteCompletion: (() -> Void)?
    
    var category: String {
        note?.category ?? "Other"
    }
    
    var city: String {
        note?.city ?? ""
    }
    
    var price: String {
        String(note?.price ?? 0.0)
    }
    
    var description: String {
        note?.description ?? ""
    }
    
    required init(tripId: String, noteId: String) {
        self.tripId = tripId
        self.noteId = noteId
    }
    
    func printAA() {
        //print("\(trip.id) - BBBBBBBB")
    }
    
    func addNote(category: String, city: String, price: Double, isFavourite: Bool, description: String) {
        fire.addNote(tripId: tripId, category: category, city: city, price: price, isFavourite: isFavourite, description: description)
    }
    
    func downloadNote() {
        fire.downloadNote(tripId: tripId, noteId: noteId) { (result: Result<TripNote, Error>)  in
            switch result {
            case .success(let note):
                self.note = note
                self.noteCompletion?()
            case .failure(let error):
                print("\(error.localizedDescription) - JJJJJJJJJJJ")
            }
        }
    }
    
    func updateNote(city: String, category: String, description: String, price: Double) {
        fire.updateNote(tripId: tripId, noteId: note?.id ?? "", city: city, category: category, description: description, price: price)
    }
}
