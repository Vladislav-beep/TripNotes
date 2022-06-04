//
//  UserDefaltsServiceMock.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 04.06.2022.
//

import Foundation

class UserDefaltsServiceMock: UserDefaultsServiceProtocol {
    
    var cityOrCountry: String? = nil
    
    func save(_ countryOrCity: String) {
        cityOrCountry = countryOrCity
    }
    
    func getCityOrCountry() -> String {
        return cityOrCountry ?? ""
    }
    
    func clearData() {
        cityOrCountry = nil
    }
}
