//
//  AuthServiceMock.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 24.04.2022.
//

import Foundation

class AuthServiceMock: AuthServiceProtocol {
    
    func getUserId(completion: @escaping (Result<String, AuthError>) -> Void) {
        completion(.success("123"))
    }
    
    func createNewUser(withEmail email: String, password: String, name: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ()) {
        
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ()) {
        
    }
    
    func signOut(completionSuccess: @escaping () -> (), completionError: @escaping () -> ()) {
        
    }
    
    func checkSignIn(completion: @escaping () -> Void) {
        
    }
}
