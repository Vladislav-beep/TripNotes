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
}

class FavouritesViewModel: FavouritesViewModelProtocol {
    
    let fireBaseService: FireBaseServiceProtocol
    let dateFormatterService: DateFormatterServiceProtocol
    
    required init(fireBaseService: FireBaseServiceProtocol, dateFormatterService:DateFormatterServiceProtocol, userId: String) {
        self.fireBaseService = fireBaseService
        self.dateFormatterService = dateFormatterService
        self.userId = userId
    }
    
    var userId: String
    
    var tripNotesDict: [TripNote: Trip]?
    var completion: (() -> Void)?
    
    func fetchNotes() {
        fireBaseService.fetchFavouriteNotes(forUser: userId) { (result: Result<[TripNote: Trip], Error>) in
            switch result {
            case .success(let tripNotesDict):
                self.tripNotesDict = tripNotesDict
                self.completion?()
                print("\(tripNotesDict) - dicnt from favourites")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfCells() -> Int {
        tripNotesDict?.keys.count ?? 0
    }
    

    func noteCellViewModel(for indexPath: IndexPath) -> NoteCellViewModelProtocol? {
        let notes = tripNotesDict!.keys
        var notesArray = [TripNote]()
        for item in notes {
            notesArray.append(item)
        }
        let note = notesArray[indexPath.item]
        let trips = tripNotesDict!.values
        
        var tripsArray = [Trip]()
        for trip in trips {
            tripsArray.append(trip)
        }
       
        let trip = tripsArray[indexPath.item]
        let currency = tripsArray[indexPath.item].currency
        
        return NoteCellViewModel(tripNote: note, currency: currency, trip: trip, isInfoShown: true, fireBaseService: fireBaseService, dateFormatterService: dateFormatterService, userId: userId)
    }
    
  //  func viewModelForSelectedRow(at indexpath: IndexPath) -> NoteCellViewModel {
//        let note = notes[indexpath.item]
//        return NoteCellViewModel(tripNote: note, currency: trip?.currency ?? "$", trip: trip ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: ""), isInfoShown: false, fireBaseService: fireBaseService, dateFormatterService: dateFormatterService, userId: userId)
  //  }
}
