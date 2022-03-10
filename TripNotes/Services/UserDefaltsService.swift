//
//  UserDefaltsService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 10.03.2022.
//

import Foundation

class UserDefaltsService {
    
    let userDefaults = UserDefaults.standard
    
    func setLoggedInStatus() {
        userDefaults.set(true, forKey: Constants.UserDefaults.loggedIn.rawValue)
    }
    
    func setLoggedOutStatus() {
        userDefaults.set(false, forKey: Constants.UserDefaults.loggedIn.rawValue)
    }
    
}
