//
//  AuthService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.02.2022.
//

import Foundation
import Firebase

protocol AuthServiceProtocol {
    func createNewUser(withEmail email: String, password: String, name: String)
    func signIn(withEmail email: String, password: String, completion: @escaping () -> ())
    func getUserId() -> String
}

class AuthService: AuthServiceProtocol {
  
    
    let db = Firestore.firestore()
    
    func getUserId() -> String {
        guard let currentUser = Auth.auth().currentUser else { return "" }
        
        var id = ""
        db.collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            for document in snapshot!.documents {
                let data = document.data()
                
                if data["id"] as? String == currentUser.uid {
                    print("\(document.documentID) - from AUTH")
                    id = document.documentID
                }
                
            }
        }
        return id
    }
    
    func createNewUser(withEmail email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                
                self?.db.collection("users").addDocument(data: [
                    "email": email,
                    "name": name,
                    "password": password,
                    "id": result?.user.uid ?? ""
                ])
            }
        }
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping () -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            if user != nil {
                completion()
            }
            print(error?.localizedDescription)
        }
    }
    
    
}
