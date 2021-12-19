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
    let description: String
    let currency: Currency
    let tripNotes: [TripNote]
    let avatarTrip: Data?
    
    static func getData() -> [Trip] {
       let array = [Trip(country: "Germany",
                     beginningDate: Date(),
                     finishingDate: Date(),
                     description: "With bro", currency: .ruble,
                     tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 168.87, isFavoutite: false, adress: nil)],
                     avatarTrip: nil),
                    Trip(country: "America",
                                  beginningDate: Date(timeIntervalSinceNow: -300000),
                                  finishingDate: Date(),
                                  description: "Work and travel", currency: .euro,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 72.00, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Dominicana",
                                  beginningDate: Date(timeIntervalSince1970: -5000),
                                  finishingDate: Date(),
                                  description: "Went with parents to Dominicana during New Yer. Were there 10 days, if i am not mistaken", currency: .dollar,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 2.89, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  description: "With bro", currency: .euro,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 87610.54, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  description: "With bro", currency: .ruble,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 140.32, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  description: "With bro", currency: .dollar,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 66.78, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  description: "With bro", currency: .euro,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 1154.44, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(),
                                  description: "With bro", currency: .dollar,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 12.65, isFavoutite: false, adress: nil)],
                                  avatarTrip: nil)]
        
        return array
    }
}

