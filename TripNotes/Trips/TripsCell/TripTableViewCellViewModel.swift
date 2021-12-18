//
//  TripTableViewCellViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 17.12.2021.
//

import Foundation

protocol TripTableViewCellViewModelProtocol {
    var country: String { get }
    var description: String { get }
    var date: String { get }
    init(trip: Trip)
}


class TripTableViewCellViewModel: TripTableViewCellViewModelProtocol {
    
    var description: String {
        trip.description
    }
    
    var date: String {
        "\(trip.beginningDate) - \(trip.finishingDate)"
    }
    
    var country: String {
        trip.country
    }
    
    private let trip: Trip
    
    required init(trip: Trip) {
        self.trip = trip
    }
    
}
