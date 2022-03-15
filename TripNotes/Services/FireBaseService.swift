//
//  FireBaseService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.02.2022.
//

import Foundation
import Firebase

protocol FireBaseServiceProtocol {
    func fetchTrips(forUser id: String, completion: @escaping (Result <[Trip], Error>) -> Void)
    func addTrip(forUser userId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void)
    func downloadTrip(forUser userId: String, tripId: String, completion: @escaping (Result <Trip, Error>) -> Void)
    func updateTrip(forUser userId: String, tripId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void)
    func deleteTrip(forUser userId: String, tripId: String)
    
    func fetchNotes(forUser userId: String, forTrip tripId: String, completion: @escaping (Result <[TripNote], Error>) -> Void)
    func addNote(forUser userId: String, tripId: String, category: String, city: String, price: Double, isFavourite: Bool, description: String)
    func downloadNote(forUser userId: String, tripId: String, noteId: String, completion: @escaping (Result <TripNote, Error>) -> Void)
    func updateNote(forUser userId: String, tripId: String, noteId: String, city: String, category: String, description: String, price: Double)
    func deleteNote(forUser userId: String, tripId: String, noteId: String)
    func toggleFavourite(forUser userId: String, tripId: String, noteId: String, isFavourite: Bool)
    
}

class FireBaseService: FireBaseServiceProtocol {
    
    private lazy var db = Firestore.firestore()
    private lazy var usersRef = db.collection("users")

    // MARK: Trip methods
    
    func fetchTrips(forUser id: String, completion: @escaping (Result <[Trip], Error>) -> Void) {
        db.collection("users").document(id).collection("trips").getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err.localizedDescription as! Error))
            } else {
                var tripArray = [Trip]()
                for document in querySnapshot!.documents {
                    let trip = Trip(snapshot: document)
                    tripArray.append(trip)
                }
                completion(.success(tripArray))
            }
        }
    }
    
    func addTrip(forUser userId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void) {
        
        let newTripRef = db.collection("users").document(userId).collection("trips").document()
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
    
    func downloadTrip(forUser userId: String, tripId: String, completion: @escaping (Result <Trip, Error>) -> Void) {
        let tripRef = db.collection("users").document(userId).collection("trips").document(tripId)
        tripRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let trip = Trip(document: document)
                completion(.success(trip))
               } else {
                completion(.failure(error?.localizedDescription as! Error))
                print("errrrrrrrrrrrrrrr")
               }
        }
    }
    
    func updateTrip(forUser userId: String, tripId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void) {
        let tripRef = db.collection("users").document(userId).collection("trips").document(tripId)
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
    
    func deleteTrip(forUser userId: String, tripId: String) {
        let tripRef = db.collection("users").document(userId).collection("trips").document(tripId)
        let noteCollectionRef = db.collection("users").document(userId).collection("trips").document(tripId).collection("tripNotes")
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
    
    // MARK: Note methods
        
    func fetchNotes(forUser userId: String, forTrip tripId: String, completion: @escaping (Result <[TripNote], Error>) -> Void) {
        db.collection("users").document(userId).collection("trips").document(tripId).collection("tripNotes").getDocuments { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err.localizedDescription as! Error))
            } else {
                var noteArray = [TripNote]()
                for document in querySnapshot!.documents {
                    let note = TripNote(snapshot: document)
                    noteArray.append(note)
                }
                completion(.success(noteArray))
            }
        }
    }
    
    func addNote(forUser userId: String, tripId: String, category: String, city: String, price: Double, isFavourite: Bool, description: String) {
        
        let newNoteRef = db.collection("users").document(userId).collection("trips").document(tripId).collection("tripNotes").document()
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
    
    func downloadNote(forUser userId: String, tripId: String, noteId: String, completion: @escaping (Result <TripNote, Error>) -> Void) {
        let noteRef = db.collection("users").document(userId).collection("trips").document(tripId).collection("tripNotes").document(noteId)
        noteRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let note = TripNote(document: document)
                completion(.success(note))
               } else {
                completion(.failure(error?.localizedDescription as! Error))
                print("errrrrrrrrrrrrrrr")
               }
        }
    }
    
    func updateNote(forUser userId: String, tripId: String, noteId: String, city: String, category: String, description: String, price: Double) {
        let noteRef = db.collection("users").document(userId).collection("trips").document(tripId).collection("tripNotes").document(noteId)
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
     
    func toggleFavourite(forUser userId: String, tripId: String, noteId: String, isFavourite: Bool) {
        let noteRef = db.collection("users").document(userId).collection("trips").document(tripId).collection("tripNotes").document(noteId)
        
        noteRef.updateData(["isFavourite" : isFavourite])
    }
    
    func deleteNote(forUser userId: String, tripId: String, noteId: String) {
        let noteRef = db.collection("users").document(userId).collection("trips").document(tripId).collection("tripNotes").document(noteId)
        noteRef.delete()
    }
}

