//
//  UserDefaultsService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 30.05.2022.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    func save(_ countryOrCity: String)
    func getCityOrCountry() -> String
    func clearData()
}

final class UserDefaultsService: UserDefaultsServiceProtocol {
    
    // MARK: Private properties
    
    private lazy var userDefaults = UserDefaults.standard
    private lazy var countryKey = C.UserDefaultsKeys.countryKey.rawValue
    
    
    // MARK: Methods
    
    func save(_ countryOrCity: String){
        userDefaults.set(countryOrCity, forKey: countryKey)
    }
    
    func getCityOrCountry() -> String {
        return userDefaults.object(forKey: countryKey) as? String ?? ""
    }
    
    func clearData(){
        userDefaults.removeObject(forKey: countryKey)
    }
}
