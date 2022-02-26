//
//  NewTripViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.12.2021.
//

import Foundation

protocol NewTripViewModelProtocol {
    func addTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date) 
}

class NewTripViewModel: NewTripViewModelProtocol {
    
    let fire = FireBaseService()
    
    func addTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date) {
        fire.addTrip(country: country, currency: currency, description: description, beginningDate: beginningDate, finishingDate: finishingDate)
    }
    
}
