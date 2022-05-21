//
//  TripStub.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 20.05.2022.
//

import Foundation

class TripStub {
    
    // MARK: Public
    
    func getTripsStub() -> [Trip] {
        return [
            Trip(id: "123",
                 country: "Russia",
                 beginningDate: Date(timeIntervalSinceNow: -30000),
                 finishingDate: Date(timeIntervalSinceNow: 30000),
                 description: "Trip to Russia",
                 currency: "₽"),
            Trip(id: "456",
                 country: "France",
                 beginningDate: Date(timeIntervalSinceNow: -90000),
                 finishingDate: Date(timeIntervalSinceNow: -30000),
                 description: "Trip to France",
                 currency: "$")
        ]
    }
}
