//
//  TripModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 14.12.2021.
//

import Foundation

struct Trip {
    let country: String
    let beginningDate: Data
    let finishingDate: Data
    let name: String
    let tripNotes: [TripNote]
    let avatarTrip: Data?
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
