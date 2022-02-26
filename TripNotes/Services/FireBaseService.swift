//
//  FireBaseService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.02.2022.
//

import Foundation
import Firebase

protocol FireBaseServiceProtocol {
    func listenToTrips() -> [Trip]
}

class FireBaseService {
    
    
    var tripsArray = [Trip]()
    private lazy var db = Firestore.firestore()
    
    func listenToTrips(forUser id: String, completion: @escaping (Result <[Trip], Error>) -> Void) {
        
        db.collection("users").document(id).collection("trips").getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err.localizedDescription as! Error))
            } else {
                
                var tripArray = [Trip]()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let beginningDate = (data["beginningDate"] as? Timestamp)?.dateValue()
                    let finishingDate = (data["finishingDate"] as? Timestamp)?.dateValue()
                    let trip = Trip(id: document.documentID,
                                    country: data["country"] as? String ?? "",
                                    beginningDate: beginningDate ?? Date(),
                                    finishingDate: finishingDate ?? Date(),
                                    description: data["description"] as? String ?? "",
                                    currency: data["currency"] as? String ?? "")
                    tripArray.append(trip)
                    
                }
                
                completion(.success(tripArray))
                print("\(tripArray) - from service")
            }
        }
    }
    
    func addTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date) {
        
        let newTripRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document()
        newTripRef.setData([
            "id": newTripRef.documentID,
            "country": country,
            "currency": currency,
            "description": description,
            "beginningDate": beginningDate,
            "finishingDate": finishingDate
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(newTripRef.documentID)")
            }
        }
    }
    
    
    func listenToNotes(forTrip tripId: String, completion: @escaping (Result <[TripNote], Error>) -> Void) {
        db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId).collection("tripNotes").getDocuments { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err.localizedDescription as! Error))
            } else {
                
                var noteArray = [TripNote]()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let date = (data["date"] as? Timestamp)?.dateValue()
                   
                    let note = TripNote(city: data["city"] as? String ?? "",
                                        category: data["category"] as? String ?? "",
                                        price: data["price"] as? Double ?? 0.0,
                                        date: date ?? Date(),
                                        description: data["description"] as? String ?? "",
                                        isFavourite: data["isFavourite"] as? Bool ?? false,
                                        adress: data["adress"] as? String ?? "")
                    noteArray.append(note)

                }
                completion(.success(noteArray))
                print("\(noteArray) - from service note")
            }
        }
    }
}

