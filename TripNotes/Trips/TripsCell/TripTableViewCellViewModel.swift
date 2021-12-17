//
//  TripTableViewCellViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 17.12.2021.
//

import Foundation

protocol TripTableViewCellViewModelProtocol {
    var country: String { get }
    init(trip: Trip)
}


class TripTableViewCellViewModel: TripTableViewCellViewModelProtocol {
   
    var country: String {
        trip.country
    }
    
    private let trip: Trip
    
    required init(trip: Trip) {
        self.trip = trip
    }
    
}
