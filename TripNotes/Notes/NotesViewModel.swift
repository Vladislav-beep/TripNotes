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
    var noteCompletion: (() -> Void)? { get set }
    func getNotes()
    func numberOfCells() -> Int
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol?
    func viewModelForSelectedRow(at indexpath: IndexPath) -> NoteCellViewModel
}

class NotesViewModel: NotesViewModelProtocol {
    
    let fire = FireBaseService()
    
    // MARK: Properties
    
    var text: String {
        trip?.country ?? ""
    }
    
    var notes: [TripNote] = []
    var trip: Trip?
    
    var noteCompletion: (() -> Void)?
    
    // MARK: Life time
    
    required init(trip: Trip?) {
        self.trip = trip
    }
    
    // MARK: Methods
    
    func getNotes() {
        fire.listenToNotes(forTrip: trip?.id ?? "", completion: { (result: Result<[TripNote], Error>) in
            switch result {
            case .success(let notess):
                self.notes = notess
                self.noteCompletion?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func numberOfCells() -> Int {
        notes.count
    }
    
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol? {
        let note = notes[indexPath.item]
        let currency = trip?.currency ?? "$"
        return NoteCellViewModel(tripNote: note, currency: currency, tripId: trip?.id ?? "")
    }
    
    func viewModelForSelectedRow(at indexpath: IndexPath) -> NoteCellViewModel {
        let note = notes[indexpath.item]
        return NoteCellViewModel(tripNote: note, currency: trip?.currency ?? "$", tripId: trip?.id ?? "")
    }

}
