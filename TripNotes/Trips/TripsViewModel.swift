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
    var userId: String { get set }
    var firstCompletion: (() -> Void)? { get set }
    init(fireBaseService: FireBaseServiceProtocol,
                  userId: String,
                  fileStorageService: FileStorageServiceProtocol,
                  dateFormatterService: DateFormatterServiceProtocol)
    func fetchTrips()
    func numberOfRows(section: Int) -> Int
    func titleForHeaderInSection(section: Int) -> String
    func tripCellViewModel(for indexPath: IndexPath) -> TripTableViewCellViewModelProtocol?
    func viewModelForSelectedRow(at indexPAth: IndexPath) -> NotesViewModelProtocol
    func newTripViewModelEdited(for indexPath: IndexPath?) -> NewTripViewModelProtocol
    func newTripViewModel() -> NewTripViewModelProtocol 
    func newNoteViewModel(at indexPath: IndexPath) -> NewNoteViewModelProtocol
    func deleteRow(at indexPath: IndexPath)
    func getTripId(for indexPath: IndexPath?) -> String
    
}

class TripsViewModel: TripsViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let fireBaseService: FireBaseServiceProtocol
    private let fileStorageService: FileStorageServiceProtocol
    private let dateFormatterService: DateFormatterServiceProtocol

    // MARK: Properties
    
    var trips: [Trip] = []
    var userId: String
    var firstCompletion: (() -> Void)?
    
    // MARK: Private properties
    
    private var tripMore: [Trip]?
    private var tripLow: [Trip]?
    
    // MARK: Life Time
    
    required init(fireBaseService: FireBaseServiceProtocol,
                  userId: String,
                  fileStorageService: FileStorageServiceProtocol,
                  dateFormatterService: DateFormatterServiceProtocol) {
        self.fireBaseService = fireBaseService
        self.userId = userId
        self.fileStorageService = fileStorageService
        self.dateFormatterService = dateFormatterService
    }
    
    // MARK: - Private methods
    
    private func deleteTrip(tripId: String) {
        fireBaseService.deleteTrip(forUser: userId, tripId: tripId)
    }
    
    // MARK: - Methods
    
    func fetchTrips() {
        fireBaseService.fetchTrips(forUser: userId, completion: { (result: Result<[Trip], Error>) in
            switch result {
            case .success(let tripss):
                self.trips = tripss
                self.firstCompletion?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func numberOfRows(section: Int) -> Int {
        tripMore = trips
            .filter { $0.finishingDate > Date() }
            .sorted(by: { $0.finishingDate > $1.finishingDate })
        tripLow = trips
            .filter { $0.finishingDate < Date() }
            .sorted(by: { $0.finishingDate > $1.finishingDate })
        let plannedCount = tripMore?.count ?? 0
        let finishedCount = tripLow?.count ?? 0
        
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
            let trip = (tripMore?[indexPath.row]) ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
            return TripTableViewCellViewModel(fileStorageService: fileStorageService, dateFormatterService: dateFormatterService, trip: trip)
        } else {
            let trip = tripLow?[indexPath.row] ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
            return TripTableViewCellViewModel(fileStorageService: fileStorageService, dateFormatterService: dateFormatterService, trip: trip)
        }
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> NotesViewModelProtocol {
        if indexPath.section == 0 {
            let trip = (tripMore?[indexPath.row]) ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
            return NotesViewModel(trip: trip, fireBaseService: fireBaseService, dateFormatterService: dateFormatterService, userId: userId)
        } else {
            let trip = tripLow?[indexPath.row] ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
            return NotesViewModel(trip: trip, fireBaseService: fireBaseService, dateFormatterService: dateFormatterService, userId: userId)
        }
    }
    
    func newTripViewModelEdited(for indexPath: IndexPath?) -> NewTripViewModelProtocol {
        let tripId = getTripId(for: indexPath ?? IndexPath())
        return NewTripViewModel(tripId: tripId, userId: userId, fireBaseService: fireBaseService, fileStorageService: fileStorageService)
    }
    
    func newTripViewModel() -> NewTripViewModelProtocol {
        return NewTripViewModel(tripId: "", userId: userId, fireBaseService: fireBaseService, fileStorageService: fileStorageService)
    }
    
    func newNoteViewModel(at indexPath: IndexPath) -> NewNoteViewModelProtocol {
        if indexPath.section == 0 {
            let trip = (tripMore?[indexPath.row]) ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
            return NewNoteViewModel(userId: userId, tripId: trip.id, noteId: "", fireBaseService: fireBaseService)
        } else {
            let trip = tripLow?[indexPath.row] ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
            return NewNoteViewModel(userId: userId, tripId: trip.id, noteId: "", fireBaseService: fireBaseService)
        }
    }
    
    func deleteRow(at indexPath: IndexPath) {
        if indexPath.section == 0 {
            let trip = tripMore?[indexPath.row]
            for (index, tripp) in trips.enumerated() {
                if tripp == trip {
                    trips.remove(at: index)
                    deleteTrip(tripId: tripp.id)
                }
            }
        } else {
            let trip = tripLow?[indexPath.row]
            for (index, tripp) in trips.enumerated() {
                if tripp == trip {
                    trips.remove(at: index)
                    deleteTrip(tripId: tripp.id)
                }
            }
        }
    }
    
    func getTripId(for indexPath: IndexPath?) -> String {
        if indexPath?.section == 0 {
            let trip = (tripMore?[indexPath?.row ?? 0]) ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
            return trip.id
        } else {
            let trip = tripLow?[indexPath?.row ?? 0] ?? Trip(id: "", country: "", beginningDate: Date(), finishingDate: Date(), description: "", currency: "")
            return trip.id
        }
    }
}
