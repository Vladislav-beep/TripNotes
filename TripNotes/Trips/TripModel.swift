//
//  TripModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 14.12.2021.
//

import Foundation

struct Trip {
    let country: String
    let beginningDate: Date
    let finishingDate: Date
    let name: String
    let tripNotes: [TripNote]
    let avatarTrip: Data?
    
    static func getData() -> [Trip] {
       let array = [Trip(country: "Germany",
                     beginningDate: Date(),
                     finishingDate: Date(),
                     name: "With bro",
                     tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 68, currency: .euro, isFavoutite: false, adress: nil)],
                     avatarTrip: nil),
                    Trip(country: "America",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  name: "With bro",
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 68, currency: .euro, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Dominicana",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  name: "With bro",
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 68, currency: .euro, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  name: "With bro",
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 68, currency: .euro, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  name: "With bro",
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 68, currency: .euro, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  name: "With bro",
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 68, currency: .euro, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  name: "With bro",
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 68, currency: .euro, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  name: "With bro",
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 68, currency: .euro, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil)]
        
        return array
    }
}

struct TripNote {
    let city: String
    let category: Category
    let price: Double
    let currency: Currency
    let isFavoutite: Bool
    let adress: String?
}

enum Category {
    case hotels
    case tranport
    case foodAndRestaurants
    case activity
    case purchases
    case other
}

enum Currency {
    case ruble
    case dollar
    case euro
}
