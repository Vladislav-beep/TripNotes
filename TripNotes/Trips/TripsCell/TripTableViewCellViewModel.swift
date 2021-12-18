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
    func getTotalSum() -> String
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
    
    func getTotalSum() -> String {
        var totalSum: Double = 0
        
        for note in trip.tripNotes {
            totalSum += Double(note.price)
        }
        
        let roundedTotalSum = String(format: "%.2f", totalSum)
        let stringTotalSum = "\(roundedTotalSum) \(trip.currency.rawValue)"
        return stringTotalSum
    }
}
