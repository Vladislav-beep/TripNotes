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
}


class AuthViewModel: AuthViewModelProtocol {
    
    let auth = AuthService()
    
    func signIn(withEmail email: String, password: String, completion: @escaping () -> ()) {
        auth.signIn(withEmail: email, password: password, completion: completion)
    }
    

}
