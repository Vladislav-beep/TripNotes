//
//  AuthService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.02.2022.
//

import Foundation
import Firebase

protocol AuthServiceProtocol {
    var completion: ((String) -> Void)? { get set }
    func getUserId(completion: @escaping (Result<String, Error>) -> Void)
    func createNewUser(withEmail email: String, password: String, name: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ())
    func signIn(withEmail email: String, password: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ())
    func checkSignIn(completion: @escaping () -> Void)
    
}

class AuthService: AuthServiceProtocol {
  
    let db = Firestore.firestore()
    
    var completion: ((String) -> Void)?
    

    func getUserId(completion: @escaping (Result<String, Error>) -> Void) {
            guard let currentUser = Auth.auth().currentUser else { return }
    
            db.collection("users").getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error.localizedDescription as! Error))
                }
                for document in snapshot!.documents {
                    let data = document.data()
    
                    if data["id"] as? String == currentUser.uid {
                        print("\(document.documentID) - from AUTH")
                        completion(.success(document.documentID))
                    }
                }
            }
        }
    
    func createNewUser(withEmail email: String, password: String, name: String, completion: @escaping () -> (), errorCompletion: @escaping () -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if error != nil {
                errorCompletion()
                print(error?.localizedDescription)
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
                print(error?.localizedDescription)
                return
            }
            if user != nil {
                completion()
            }
            print(error?.localizedDescription)
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
