//
//  UserDefaltsServiceMock.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 04.06.2022.
//

import Foundation

class UserDefaltsServiceMock: UserDefaultsServiceProtocol {
    
    func save(_ countryOrCity: String) {
        
    }
    
    func getCityOrCountry() -> String {
        return "Москва"
    }
    
    func clearData() {
    
    }
}
