//
//  AuthViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 24.01.2022.
//

import Foundation
import Firebase

protocol AuthViewModelProtocol {
    init(authService: AuthServiceProtocol)
    func signIn(withEmail email: String, password: String, completion: @escaping () -> (), errorComletion: @escaping () -> ())
    func checkSignIn(completion: @escaping () -> Void)
}

class AuthViewModel: AuthViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let authService: AuthServiceProtocol
    
    // MARK: - Life Time
    
    required init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Methods
    
    func signIn(withEmail email: String, password: String, completion: @escaping () -> (), errorComletion: @escaping () -> ()) {
        authService.signIn(withEmail: email, password: password, completion: completion, errorCompletion: errorComletion)
    }
    
    func checkSignIn(completion: @escaping () -> Void) {
        authService.checkSignIn {
            completion()
        }
    }
}
