//
//  NewAccountViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 25.01.2022.
//

import Foundation

protocol NewAccountViewModelProtocol {
    init(authService: AuthServiceProtocol)
    func createNewUser(withEmail email: String, password: String, name: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ())
}

class NewAccountViewModel: NewAccountViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let authService: AuthServiceProtocol
    
    // MARK: - Life Time
    
    required init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Methods
    
    func createNewUser(withEmail email: String,
                       password: String,
                       name: String,
                       completion: @escaping () -> (),
                       errorCompletion: @escaping () -> ()) {
        authService.createNewUser(withEmail: email, password: password, name: name, completion: completion, errorCompletion: errorCompletion)
    }
}
