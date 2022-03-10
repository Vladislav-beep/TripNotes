//
//  AuthViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 24.01.2022.
//

import Foundation
import Firebase

protocol AuthViewModelProtocol {
    func signIn(withEmail email: String, password: String, completion: @escaping () -> ())
    func setLoggedInStatus()
}


class AuthViewModel: AuthViewModelProtocol {
    
    let auth = AuthService()
    let userDefaults = UserDefaltsService()
    
    func signIn(withEmail email: String, password: String, completion: @escaping () -> ()) {
        auth.signIn(withEmail: email, password: password, completion: completion)
    }
    
    func setLoggedInStatus() {
        userDefaults.setLoggedInStatus()
    }

}
