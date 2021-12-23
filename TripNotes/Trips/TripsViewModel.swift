//
//  TripsViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 16.12.2021.
//

import Foundation

protocol TripsViewModelProtocol: class {
    var trips: [Trip] { get set }
    func getTrips(completion: @escaping() -> Void)
    func numberOfRows(section: Int) -> Int
    func titleForHeaderInSection(section: Int) -> String
    func tripCellViewModel(for indexPath: IndexPath) -> TripTableViewCellViewModelProtocol?
    func viewModelForSelectedRow(at indexPAth: IndexPath) -> NotesViewModelProtocol
    func newTripViewModel() -> NewTripViewModelProtocol
}

class TripsViewModel: TripsViewModelProtocol {
  
    var trips: [Trip] = []
    
    
    func getTrips(completion: @escaping () -> Void) {
        trips = Trip.getData()
        completion()
    }
       
    
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
        switch  section {
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
}
