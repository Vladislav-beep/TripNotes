//
//  TripsViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 16.12.2021.
//

import Foundation

protocol TripsViewModelProtocol: class {
    var trips: [Trip] { get }
    func getTrips(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func tripCellViewModel(for indexPath: IndexPath) -> TripTableViewCellViewModelProtocol?
}

class TripsViewModel: TripsViewModelProtocol {
    
    var trips: [Trip] = []
    
    func getTrips(completion: @escaping () -> Void) {
        trips = Trip.getData()
        completion()
    }
    
   
    
    func numberOfRows() -> Int {
        trips.count
    }
    
    func tripCellViewModel(for indexPath: IndexPath) -> TripTableViewCellViewModelProtocol? {
        let trip = trips[indexPath.row]
        return TripTableViewCellViewModel(trip: trip)
    }
}
