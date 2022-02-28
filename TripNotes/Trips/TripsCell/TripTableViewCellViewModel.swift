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
    var avatarTrip: Data? { get }
    func getTotalSum() -> String
    init(trip: Trip)
}


class TripTableViewCellViewModel: TripTableViewCellViewModelProtocol {
    
    // MARK: Properties
    
    let image = "placeHolder1"
    
    var avatarTrip: Data? {
        nil
    }
    
    var description: String {
        trip.description
    }
    
    var date: String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        
        let bdate = dateformatter.string(from: trip.beginningDate)
        let fdate = dateformatter.string(from: trip.finishingDate)
        return "\(bdate) - \(fdate)"
    }
    
    var country: String {
        trip.country
    }
    
    // MARK: Private properties
    
    private let trip: Trip
    
    // MARK: Life Time
    
    required init(trip: Trip) {
        self.trip = trip
    }
    
    // MARK: Methods
    
    func getTotalSum() -> String {
        var totalSum: Double = 0
        
//        for note in trip.tripNotes {
//            totalSum += Double(note.price)
//        }
//
//        let formattedTotalSum = totalSum.formattedWithSeparator
        let returnTotalSum = "\(88) \(trip.currency)"
        return returnTotalSum
    }
}
