//
//  AuthService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.02.2022.
//

import Foundation
import Firebase

enum AuthError: Error {
    case badURL
    case badData
    case networkProblem
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad URL"
        case .badData:
            return "No data"
        case .networkProblem:
            return "Network problem"
        }
    }
}

protocol AuthServiceProtocol {
    func getUserId(completion: @escaping (Result<String, AuthError>) -> Void)
    func createNewUser(withEmail email: String, password: String, name: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ())
    func signIn(withEmail email: String, password: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ())
    func checkSignIn(completion: @escaping () -> Void)
    
}

class AuthService: AuthServiceProtocol {
    
    // MARK: - Private properties
  
    private let db = Firestore.firestore()

    // MARK: - Methods
    
    func getUserId(completion: @escaping (Result<String, AuthError>) -> Void) {
            guard let currentUser = Auth.auth().currentUser else { return }
    
            db.collection("users").getDocuments { (snapshot, error) in
                if error != nil {
                    completion(.failure(AuthError.badURL))
                }
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
    
                    if data["id"] as? String == currentUser.uid {
                        completion(.success(document.documentID))
                    }
                }
            }
        }
    
    func createNewUser(withEmail email: String, password: String, name: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if error != nil {
                errorCompletion()
            } else {
                self?.db.collection("users").addDocument(data: [
                    "email": email,
                    "name": name,
                    "password": password,
                    "id": result?.user.uid ?? ""
                ])
                completion()
            }
        }
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                errorCompletion()
                return
            }
            if user != nil {
                completion()
            }
        }
    }
    
    func checkSignIn(completion: @escaping () -> Void) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                completion()
            }
        }
    }
}
