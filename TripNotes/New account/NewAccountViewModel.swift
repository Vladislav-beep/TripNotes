//
//  NewAccountViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 25.01.2022.
//

import Foundation

protocol NewAccountViewModelProtocol {
    func createNewUser(withEmail email: String, password: String, name: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ())
}

class NewAccountViewModel: NewAccountViewModelProtocol {
    
    let fire = AuthService()
    
    func createNewUser(withEmail email: String,
                       password: String,
                       name: String,
                       completion: @escaping () -> (),
                       errorCompletion: @escaping () -> ()) {
        fire.createNewUser(withEmail: email, password: password, name: name, completion: completion, errorCompletion: errorCompletion)
    }
}
