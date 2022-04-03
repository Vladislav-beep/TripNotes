//
//  NotesViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

protocol NotesViewModelProtocol {
    var text: String { get }
    var totalSum: String { get }
    var noteCompletion: (() -> Void)? { get set }
    var errorCompletion: ((FireBaseError) -> Void)? { get set }
    init(trip: Trip?,
         fireBaseService: FireBaseServiceProtocol,
         dateFormatterService: DateFormatterServiceProtocol,
         userId: String)
    func fetchNotes()
    func numberOfCells() -> Int
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol?
    func viewModelForSelectedRow(at indexpath: IndexPath) -> NoteCellViewModel
}

class NotesViewModel: NotesViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let fireBaseService: FireBaseServiceProtocol
    private let dateFormatterService: DateFormatterServiceProtocol
    
    // MARK: - Properties
    
    var text: String {
        trip?.country ?? ""
    }
    
    
    var totalSum: String {
        var sum = 0.0
        for note in notes {
            sum += note.price
        }
        return "\(sum.formattedWithSeparator) \(trip?.currency ?? "")"
    }
    
    
    var notes: [TripNote] = []
    var trip: Trip?
    var userId: String
    
    var noteCompletion: (() -> Void)?
    var errorCompletion: ((FireBaseError) -> Void)?
    
    // MARK: - Life time
    
    required init(trip: Trip?, fireBaseService: FireBaseServiceProtocol, dateFormatterService: DateFormatterServiceProtocol, userId: String) {
        self.trip = trip
        self.fireBaseService = fireBaseService
        self.dateFormatterService = dateFormatterService
        self.userId = userId
    }
    
    // MARK: - Methods
    
    func fetchNotes() {
        fireBaseService.fetchNotes(forUser: userId, forTrip: trip?.id ?? "", completion: { [weak self] (result: Result<[TripNote], FireBaseError>) in
            switch result {
            case .success(let notess):
                self?.notes = notess
                self?.notes.sort(by: { $0.date > $1.date })
                self?.noteCompletion?()
            case .failure(let error):
                self?.errorCompletion?(error)
            }
        })
    }
    
    func numberOfCells() -> Int {
        notes.count
    }
    
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol? {
        let note = notes[indexPath.item]
        let currency = trip?.currency ?? "$"
        return NoteCellViewModel(tripNote: note, currency: currency, trip: trip ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: ""), isInfoShown: false, fireBaseService: fireBaseService, dateFormatterService: dateFormatterService, userId: userId)
    }
    
    func viewModelForSelectedRow(at indexpath: IndexPath) -> NoteCellViewModel {
        let note = notes[indexpath.item]
        return NoteCellViewModel(tripNote: note, currency: trip?.currency ?? "$", trip: trip ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: ""), isInfoShown: false, fireBaseService: fireBaseService, dateFormatterService: dateFormatterService, userId: userId)
    }
}
