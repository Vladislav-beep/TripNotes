//
//  TripModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 14.12.2021.
//

import Foundation

struct Trip {
    let id: String
    let country: String
    let beginningDate: Date
    let finishingDate: Date
    let description: String
    let currency: String
    
//    static func getData() -> [Trip] {
//       let array = [Trip(country: "Germany",
//                     beginningDate: Date(),
//                     finishingDate: Date(),
//                     description: "With bro", currency: .ruble,
//                     tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 168.87, date: Date(), description: "Hotel living", isFavourite: false, adress: nil)],
//                     avatarTrip: nil),
//                    Trip(country: "America",
//                                  beginningDate: Date(timeIntervalSinceNow: -300000),
//                                  finishingDate: Date(timeIntervalSinceNow: 300000),
//                                  description: "Work and travel", currency: .euro,
//                                  tripNotes: [
//                                    TripNote(city: "Berlin", category: .hotels, price: 1172.00, date: Date(), description: "Hotel living", isFavourite: false, adress: nil),
//                                    TripNote(city: "Glasgow", category: .activity, price: 34452697899779.00, date: Date(), description: "Technishe museum", isFavourite: true, adress: nil),
//                                    TripNote(city: "Munchen", category: .foodAndRestaurants, price: 2.33, date: Date(), description: "Sossage restaurant", isFavourite: false, adress: "13 Strasse"),
//                                    TripNote(city: "Berlin", category: .purchases, price: 14.4, date: Date(), description: "T-shirt", isFavourite: true, adress: nil),
//                                    TripNote(city: "London", category: .tranport, price: 2.75, date: Date(), description: "Bus ticket", isFavourite: false, adress: nil),
//                                    TripNote(city: "London", category: .other, price: 5.78, date: Date(), description: "Я попрошу тебя: оставь мне, пожалуйста, свою тень. В платье, украшенном солнечными бликами, пробившимися сквозь кленовую листву. Оставь мне свою тень, ведь завтра взойдет солнце, и у тебя будет точно такая же прекрасная тень. Не бойся, я не буду смотреть на землю, чтобы нечаянно не увидеть, как твоя тень положит свои руки на чьи-то плечи. Нет, я буду беречь твою тонкую стройную тень, а когда пойдет дождь, я верну тебе ее, и ты, гордая, пойдешь по городу.", isFavourite: true, adress: nil)],
//                                  avatarTrip: nil),
//                    Trip(country: "Dominicana",
//                                  beginningDate: Date(timeIntervalSince1970: -5000),
//                                  finishingDate: Date(timeIntervalSinceNow: 300),
//                                  description: "Went with parents to Dominicana during New Yer. Were there 10 days, if i am not mistaken", currency: .dollar,
//                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 2.89, date: Date(), description: "Hotel livng", isFavourite: false, adress: nil)],
//                                  avatarTrip: nil),
//                    Trip(country: "Egypt",
//                                  beginningDate: Date(),
//                                  finishingDate: Date(timeIntervalSinceNow: 500000),
//                                  description: "With bro", currency: .euro,
//                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 87610.54,date: Date(), description: "Hotel livng", isFavourite: false, adress: nil)],
//                                  avatarTrip: nil),
//                    Trip(country: "Mavriciu",
//                                  beginningDate: Date(),
//                                  finishingDate: Date(timeIntervalSinceNow: 4000),
//                                  description: "With bro", currency: .ruble,
//                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 140.32, date: Date(), description: "Hotel livng", isFavourite: false, adress: nil)],
//                                  avatarTrip: nil),
//                    Trip(country: "Madacascar",
//                                  beginningDate: Date(),
//                                  finishingDate: Date(timeIntervalSinceNow: 40000),
//                                  description: "With bro", currency: .dollar,
//                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 66.78, date: Date(), description: "Hotel livng", isFavourite: false, adress: nil)],
//                                  avatarTrip: nil),
//                    Trip(country: "Italy",
//                                  beginningDate: Date(),
//                                  finishingDate: Date(timeIntervalSinceNow: 600000),
//                                  description: "With bro", currency: .euro,
//                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 1154.44, date: Date(), description: "Hotel livng", isFavourite: false, adress: nil)],
//                                  avatarTrip: nil),
//                    Trip(country: "Norway",
//                                  beginningDate: Date(),
//                                  finishingDate: Date(timeIntervalSinceNow: 20000),
//                                  description: "With bro", currency: .dollar,
//                                  tripNotes: [TripNote(city: "Berlin", category: .hotels, price: 12.65, date: Date(), description: "Hotel livng", isFavourite: false, adress: nil)],
//                                  avatarTrip: nil)]
//        
//        return array
//    }
}

