//
//  TripsViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 16.12.2021.
//

import Foundation
import Firebase

protocol TripsViewModelProtocol: class {
    var trips: [Trip] { get set }
    func getTrips()
    func numberOfRows(section: Int) -> Int
    func titleForHeaderInSection(section: Int) -> String
    func tripCellViewModel(for indexPath: IndexPath) -> TripTableViewCellViewModelProtocol?
    func viewModelForSelectedRow(at indexPAth: IndexPath) -> NotesViewModelProtocol
    func newTripViewModel() -> NewTripViewModelProtocol
    func newNoteViewModel() -> NewNoteViewModelProtocol
    var firstCompletion: (() -> Void)? { get set }
    
}

class TripsViewModel: TripsViewModelProtocol {
    
    let fire = FireBaseService()
    
    // MARK: Properties
    
    var trips: [Trip] = []
    let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    // MARK: Methods
    
    func getTrips() {
        fire.listenToTrips(forUser: userId, completion: { (result: Result<[Trip], Error>) in
            switch result {
            case .success(let tripss):
                self.trips = tripss
                self.firstCompletion?()
                print("\(self.trips) - from viewmodel")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    var firstCompletion: (() -> Void)?
    
    func numberOfRows(section: Int) -> Int {
        var plannedCount = 0
        var finishedCount = 0
        
        for trip in trips {
            if trip.finishingDate > Date() {
                plannedCount += 1
            } else {
                finishedCount += 1
            }
        }
        switch section {
        case 0:
            return plannedCount
        case 1:
            return finishedCount
        default:
            return 0
        }
    }
    
    func titleForHeaderInSection(section: Int) -> String {
        switch section {
        case 0:
            return Constants.SectionTripNames.planned.rawValue
        case 1:
            return Constants.SectionTripNames.past.rawValue
        default:
            return ""
        }
    }
    
    func tripCellViewModel(for indexPath: IndexPath) -> TripTableViewCellViewModelProtocol? {
        if indexPath.section == 0 {
            let tr =  trips.filter { $0.finishingDate > Date() }
            let trip = tr[indexPath.row]
            return TripTableViewCellViewModel(trip: trip)
        } else {
            let tr = trips.filter { $0.finishingDate < Date() }
            let trip = tr[indexPath.row]
            return TripTableViewCellViewModel(trip: trip)
        }
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> NotesViewModelProtocol {
        if indexPath.section == 0 {
            let tr =  trips.filter { $0.finishingDate > Date() }
            let trip = tr[indexPath.row]
            return NotesViewModel(trip: trip)
        } else {
            let tr = trips.filter { $0.finishingDate < Date() }
            let trip = tr[indexPath.row]
            return NotesViewModel(trip: trip)
        }
    }
    
    func newTripViewModel() -> NewTripViewModelProtocol {
        return NewTripViewModel()
    }
    
    func newNoteViewModel() -> NewNoteViewModelProtocol {
        return NewNoteViewModel()
    }
}
