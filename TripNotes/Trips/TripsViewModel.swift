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
    func newTripViewModelEdited(for indexPath: IndexPath?) -> NewTripViewModelProtocol
    func newTripViewModel() -> NewTripViewModelProtocol 
    func newNoteViewModel(at indexPath: IndexPath) -> NewNoteViewModelProtocol
    func deleteRow(at indexPath: IndexPath)
    var firstCompletion: (() -> Void)? { get set }
    
}

class TripsViewModel: TripsViewModelProtocol {
    
    let fire = FireBaseService()
    
    // MARK: Properties
    
    var trips: [Trip] = []

    let userId: String
    
 //   var plannedCount = 0
  //  var finishedCount = 0
    
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
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    var firstCompletion: (() -> Void)?
    
    func numberOfRows(section: Int) -> Int {
        let plannedCount = trips.filter { $0.finishingDate > Date() }.count
        let finishedCount = trips.count - plannedCount
        
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
            let tr = trips.filter { $0.finishingDate > Date() }
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
            let tr = trips.filter { $0.finishingDate > Date() }
            let trip = tr[indexPath.row]
            return NotesViewModel(trip: trip)
        } else {
            let tr = trips.filter { $0.finishingDate < Date() }
            let trip = tr[indexPath.row]
            return NotesViewModel(trip: trip)
        }
    }
    
    func newTripViewModelEdited(for indexPath: IndexPath?) -> NewTripViewModelProtocol {
        let tripId = getTripId(for: indexPath ?? IndexPath())
        return NewTripViewModel(tripId: tripId)
    }
    
    func newTripViewModel() -> NewTripViewModelProtocol {
        return NewTripViewModel(tripId: "")
    }
    
    func newNoteViewModel(at indexPath: IndexPath) -> NewNoteViewModelProtocol {
        if indexPath.section == 0 {
            let tr =  trips.filter { $0.finishingDate > Date() }
            let trip = tr[indexPath.row]
            return NewNoteViewModel(tripId: trip.id, noteId: "")
        } else {
            let tr = trips.filter { $0.finishingDate < Date() }
            let trip = tr[indexPath.row]
            return NewNoteViewModel(tripId: trip.id, noteId: "")
        }
    }
    
    func deleteRow(at indexPath: IndexPath) {
        if indexPath.section == 0 {
          //  trips.filter { $0.finishingDate > Date() }.remove(at: indexPath.row)
          //  plannedCount -= 1
          //  tr.remove(at: indexPath.row)
            print("\(indexPath)- DDDDDDDDD")
        } else {
            var tr = trips.filter { $0.finishingDate < Date() }
           // let trip = tr[indexPath.row]
// finishedCount -= 1
            print("\(indexPath)- DDDDDDDDD")
            tr.remove(at: indexPath.row)
        }
    }
    
    func getTripId(for indexPath: IndexPath?) -> String {
       
        if indexPath?.section == 0 {
            let tr =  trips.filter { $0.finishingDate > Date() }
            let trip = tr[indexPath?.row ?? 0]
            return trip.id
        } else {
            let tr = trips.filter { $0.finishingDate < Date() }
            let trip = tr[indexPath?.row ?? 0]
            return trip.id
        }
    }
    
}
