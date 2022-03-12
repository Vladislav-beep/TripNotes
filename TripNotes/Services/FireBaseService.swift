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
            }
        }
    }
    
    func getTotalSumOfNotes() {
        
    }
    
    func addTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void) {
        
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
                completion(newTripRef.documentID)
                print("Document added with ID: \(newTripRef.documentID)")
            }
        }
    }
    
    func downloadTrip(tripId: String, completion: @escaping (Result <Trip, Error>) -> Void) {
        let tripRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId)
        tripRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let beginningDate = (data?["beginningDate"] as? Timestamp)?.dateValue()
                let finishingDate = (data?["finishingDate"] as? Timestamp)?.dateValue()
                let trip = Trip(id: data?["id"] as? String ?? "",
                                country: data?["country"] as? String ?? "",
                                beginningDate: beginningDate ?? Date(),
                                finishingDate: finishingDate ?? Date(),
                                description: data?["description"] as? String ?? "",
                                currency: data?["currency"] as? String ?? "")
                completion(.success(trip))
               } else {
                completion(.failure(error?.localizedDescription as! Error))
                print("errrrrrrrrrrrrrrr")
               }
        }
    }
    
    func updateTrip(tripId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void) {
        let tripRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId)
        tripRef.updateData([
            "country": country,
            "beginningDate": beginningDate,
            "finishingDate": finishingDate,
            "description": description,
            "currency": currency
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                completion(tripRef.documentID)
                print("Document successfully updated")
            }
        }
    }
    
    func deleteTrip(tripId: String) {
        let tripRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId)
        let noteCollectionRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId).collection("tripNotes")
        tripRef.delete()
        noteCollectionRef.getDocuments { (snaphot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                for doc in snaphot!.documents {
                    let docref = self.db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId).collection("tripNotes").document(doc.documentID)
                    docref.delete()
                }
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
                   
                    let note = TripNote(id: data["id"] as? String ?? "",
                                        city: data["city"] as? String ?? "",
                                        category: data["category"] as? String ?? "",
                                        price: data["price"] as? Double ?? 0.0,
                                        date: date ?? Date(),
                                        description: data["description"] as? String ?? "",
                                        isFavourite: data["isFavourite"] as? Bool ?? false,
                                        adress: data["adress"] as? String ?? "")
                    noteArray.append(note)

                }
                completion(.success(noteArray))
            }
        }
    }
    
    func updateNote(tripId: String, noteId: String, city: String, category: String, description: String, price: Double) {
        let noteRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId).collection("tripNotes").document(noteId)
        noteRef.updateData([
            "city": city,
            "price": price,
            "description": description,
            "category": category
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func downloadNote(tripId: String, noteId: String, completion: @escaping (Result <TripNote, Error>) -> Void) {
        let noteRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId).collection("tripNotes").document(noteId)
        noteRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let date = (data?["date"] as? Timestamp)?.dateValue()
               
                let note = TripNote(id: data?["id"] as? String ?? "",
                                    city: data?["city"] as? String ?? "",
                                    category: data?["category"] as? String ?? "",
                                    price: data?["price"] as? Double ?? 0.0,
                                    date: date ?? Date(),
                                    description: data?["description"] as? String ?? "",
                                    isFavourite: data?["isFavourite"] as? Bool ?? false,
                                    adress: data?["adress"] as? String ?? "")
                completion(.success(note))
               } else {
                completion(.failure(error?.localizedDescription as! Error))
                print("errrrrrrrrrrrrrrr")
               }
        }
    }
    
    
    func addNote(tripId: String, category: String, city: String, price: Double, isFavourite: Bool, description: String) {
        
        let newNoteRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId).collection("tripNotes").document()
        newNoteRef.setData([
            "id": newNoteRef.documentID,
            "city": city,
            "category": category,
            "description": description,
            "price": price,
            "isFavourite": isFavourite,
            "date": Date()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(newNoteRef.documentID)")
            }
        }
    }
    
    func toggleFavourite(tripId: String, noteId: String, isFavourite: Bool) {
        let noteRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId).collection("tripNotes").document(noteId)
        
        noteRef.updateData(["isFavourite" : isFavourite])
    }
    
    func deleteNote(tripId: String, noteId: String) {
        let noteRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").document(tripId).collection("tripNotes").document(noteId)
        noteRef.delete()
    }
    
}

