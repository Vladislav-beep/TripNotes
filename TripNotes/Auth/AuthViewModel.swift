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
    
    // MARK: Dependencies
    
    let auth: AuthServiceProtocol
    
    // MARK: Life Time
    
    required init(authService: AuthServiceProtocol) {
        self.auth = authService
    }
    
    // MARK: Methods
    
    func signIn(withEmail email: String, password: String, completion: @escaping () -> (), errorComletion: @escaping () -> ()) {
        auth.signIn(withEmail: email, password: password, completion: completion, errorCompletion: errorComletion)
    }
    
    func checkSignIn(completion: @escaping () -> Void) {
        auth.checkSignIn {
            completion()
        }
    }
}
