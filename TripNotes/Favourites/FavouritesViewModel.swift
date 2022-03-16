//
//  FavouritesViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 03.02.2022.
//

import Foundation

protocol FavouritesViewModelProtocol {
    var completion: (() -> Void)? { get set }
    func numberOfCells() -> Int
    init(fireBaseService: FireBaseServiceProtocol, dateFormatterService: DateFormatterServiceProtocol,  userId: String)
    func fetchNotes()
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol?
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let fireBaseService: FireBaseServiceProtocol
    private let dateFormatterService: DateFormatterServiceProtocol
    
    // MARK: - Private properties
    
    private var tripNotesDict: [TripNote: Trip]?
    
    private var notesArray: [TripNote] {
        let notes = tripNotesDict!.keys
        var notesArr = [TripNote]()
        for note in notes {
            notesArr.append(note)
        }
        return notesArr
    }
    
    private var tripsArray: [Trip] {
        let trips = tripNotesDict!.values
        
        var tripsArr = [Trip]()
        for trip in trips {
            tripsArr.append(trip)
        }
        return tripsArr
    }
    
    // MARK: - Properties
    
    var userId: String
    var completion: (() -> Void)?
    
    // MARK: - Life Time
    
    required init(fireBaseService: FireBaseServiceProtocol, dateFormatterService:DateFormatterServiceProtocol, userId: String) {
        self.fireBaseService = fireBaseService
        self.dateFormatterService = dateFormatterService
        self.userId = userId
    }
    
    func fetchNotes() {
        fireBaseService.fetchFavouriteNotes(forUser: userId) { (result: Result<[TripNote: Trip], Error>) in
            switch result {
            case .success(let tripNotesDict):
                self.tripNotesDict = tripNotesDict
                self.completion?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfCells() -> Int {
        tripNotesDict?.keys.count ?? 0
    }
    
    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol? {
        let note = notesArray[indexPath.item]
        let trip = tripsArray[indexPath.item]
        let currency = tripsArray[indexPath.item].currency
        return NoteCellViewModel(tripNote: note,
                                 currency: currency,
                                 trip: trip,
                                 isInfoShown: true,
                                 fireBaseService: fireBaseService,
                                 dateFormatterService: dateFormatterService,
                                 userId: userId)
    }
    
  //  func viewModelForSelectedRow(at indexpath: IndexPath) -> NoteCellViewModel {
//        let note = notes[indexpath.item]
//        return NoteCellViewModel(tripNote: note, currency: trip?.currency ?? "$", trip: trip ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: ""), isInfoShown: false, fireBaseService: fireBaseService, dateFormatterService: dateFormatterService, userId: userId)
  //  }
}
