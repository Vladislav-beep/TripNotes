//
//  FavouritesViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 03.02.2022.
//

import Foundation

protocol FavouritesViewModelProtocol {
    var completion: (() -> Void)? { get set }
    init(fireBaseService: FireBaseServiceProtocol,
         dateFormatterService: DateFormatterServiceProtocol,
         userId: String)
    func numberOfCells(isFiltering: Bool) -> Int
    func fetchNotes()
    func filterContentForSearchText(_ searchText: String)
    func noteCellViewModel(for indexPath: IndexPath, isFiltering: Bool) -> NoteCellViewModelProtocol?
    func viewModelForSelectedRow(at indexPath: IndexPath, isFiltering: Bool) -> NoteCellViewModel
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let fireBaseService: FireBaseServiceProtocol
    private let dateFormatterService: DateFormatterServiceProtocol
    
    // MARK: - Private properties
    
    private var tripNotesDict: [TripNote: Trip]?
    var notesArrayFiltered = [TripNote]()
    
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
    
    func numberOfCells(isFiltering: Bool) -> Int {
        if isFiltering {
            return notesArrayFiltered.count
        }
        return tripNotesDict?.keys.count ?? 0
    }
    
    func noteCellViewModel(for indexPath: IndexPath, isFiltering: Bool) -> NoteCellViewModelProtocol? {
        if isFiltering {
            let note = notesArrayFiltered[indexPath.item]
            let rip = tripNotesDict?[note] ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
            print(note)
            let currency = rip.currency
            return NoteCellViewModel(tripNote: note, currency: currency, trip: rip, isInfoShown: true, fireBaseService: fireBaseService, dateFormatterService: dateFormatterService, userId: userId)
        }
        let note = notesArray[indexPath.item]
        let trip = tripsArray[indexPath.item]
        let currency = tripsArray[indexPath.item].currency
        return NoteCellViewModel(tripNote: note, currency: currency, trip: trip, isInfoShown: true, fireBaseService: fireBaseService, dateFormatterService: dateFormatterService, userId: userId)
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath, isFiltering: Bool) -> NoteCellViewModel {
        if isFiltering {
            let note = notesArrayFiltered[indexPath.item]
            let rip = tripNotesDict?[note] ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
            let currency = rip.currency
            return NoteCellViewModel(tripNote: note,
                                     currency: currency,
                                     trip: rip,
                                     isInfoShown: false,
                                     fireBaseService: fireBaseService,
                                     dateFormatterService: dateFormatterService,
                                     userId: userId)
        }
        
        let note = notesArray[indexPath.item]
        let rip = tripNotesDict?[note] ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
        let currency = rip.currency
        return NoteCellViewModel(tripNote: note,
                                 currency: currency,
                                 trip: rip,
                                 isInfoShown: false,
                                 fireBaseService: fireBaseService,
                                 dateFormatterService: dateFormatterService,
                                 userId: userId)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        notesArrayFiltered = notesArray.filter({ (note: TripNote) -> Bool in
            return (note.description?.lowercased().contains(searchText.lowercased()) ?? false)
        })
    }
}
