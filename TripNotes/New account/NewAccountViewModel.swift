//
//  NewAccountViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 25.01.2022.
//

import Foundation

protocol NewAccountViewModelProtocol {
    func createNewUser(withEmail email: String, password: String, name: String)
}

class NewAccountViewModel: NewAccountViewModelProtocol {
    
    let fire = AuthService()
    
    func createNewUser(withEmail email: String, password: String, name: String) {
        fire.createNewUser(withEmail: email, password: password, name: name)
    }
}
