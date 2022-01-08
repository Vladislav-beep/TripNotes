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
                     tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 168.87, date: Date(), description: "Hotel living", isFavoutite: false, adress: nil)],
                     avatarTrip: nil),
                    Trip(country: "America",
                                  beginningDate: Date(timeIntervalSinceNow: -300000),
                                  finishingDate: Date(timeIntervalSinceNow: 300000),
                                  description: "Work and travel", currency: .euro,
                                  tripNotes: [
                                    TripNote(city: "Berlin", category: .hotels, price: 72.00, date: Date(), description: "Hotel living", isFavoutite: false, adress: nil),
                                    TripNote(city: "Glasgow", category: .activity, price: 26.00, date: Date(), description: "Technishe museum", isFavoutite: true, adress: nil),
                                    TripNote(city: "Munchen", category: .foodAndRestaurants, price: 2.33, date: Date(), description: "Sossage restaurant", isFavoutite: false, adress: "13 Strasse"),
                                    TripNote(city: "Berlin", category: .purchases, price: 14.4, date: Date(), description: "T-shirt", isFavoutite: true, adress: nil),
                                    TripNote(city: "London", category: .tranport, price: 2.75, date: Date(), description: "Bus ticket", isFavoutite: false, adress: nil),
                                    TripNote(city: "London", category: .other, price: 5.78, date: Date(), description: "Found one funt on the ground", isFavoutite: true, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Dominicana",
                                  beginningDate: Date(timeIntervalSince1970: -5000),
                                  finishingDate: Date(timeIntervalSinceNow: 300),
                                  description: "Went with parents to Dominicana during New Yer. Were there 10 days, if i am not mistaken", currency: .dollar,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 2.89, date: Date(), description: "Hotel livng", isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Egypt",
                                  beginningDate: Date(),
                                  finishingDate: Date(timeIntervalSinceNow: 500000),
                                  description: "With bro", currency: .euro,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 87610.54,date: Date(), description: "Hotel livng", isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Mavriciu",
                                  beginningDate: Date(),
                                  finishingDate: Date(timeIntervalSinceNow: 4000),
                                  description: "With bro", currency: .ruble,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 140.32, date: Date(), description: "Hotel livng", isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Madacascar",
                                  beginningDate: Date(),
                                  finishingDate: Date(timeIntervalSinceNow: 40000),
                                  description: "With bro", currency: .dollar,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 66.78, date: Date(), description: "Hotel livng", isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Italy",
                                  beginningDate: Date(),
                                  finishingDate: Date(timeIntervalSinceNow: 600000),
                                  description: "With bro", currency: .euro,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 1154.44, date: Date(), description: "Hotel livng", isFavoutite: false, adress: nil)],
                                  avatarTrip: nil),
                    Trip(country: "Norway",
                                  beginningDate: Date(),
                                  finishingDate: Date(timeIntervalSinceNow: 20000),
                                  description: "With bro", currency: .dollar,
                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 12.65, date: Date(), description: "Hotel livng", isFavoutite: false, adress: nil)],
                                  avatarTrip: nil)]
        
        return array
    }
}

