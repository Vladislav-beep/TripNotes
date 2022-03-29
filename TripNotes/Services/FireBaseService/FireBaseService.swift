//
//  FireBaseService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.02.2022.
//

import Foundation
import Firebase

protocol FireBaseServiceProtocol {
    func fetchTrips(forUser id: String, completion: @escaping (Result <[Trip], FireBaseError>) -> Void)
    func addTrip(forUser userId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void)
    func downloadTrip(forUser userId: String, tripId: String, completion: @escaping (Result <Trip, FireBaseError>) -> Void)
    func updateTrip(forUser userId: String, tripId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void)
    func deleteTrip(forUser userId: String, tripId: String, errorCompletion: @escaping () -> Void)
    
    func fetchNotes(forUser userId: String, forTrip tripId: String, completion: @escaping (Result <[TripNote], FireBaseError>) -> Void)
    func fetchFavouriteNotes(forUser userId: String, completion: @escaping (Result <[TripNote: Trip], FireBaseError>) -> Void)
    func addNote(forUser userId: String, tripId: String, category: String, city: String, price: Double, isFavourite: Bool, description: String, address: String, errorCompletion: @escaping () -> Void)
    func downloadNote(forUser userId: String, tripId: String, noteId: String, completion: @escaping (Result <TripNote, FireBaseError>) -> Void)
    func updateNote(forUser userId: String, tripId: String, noteId: String, city: String, category: String, description: String, price: Double, address: String, errorCompletion: @escaping () -> Void)
    func deleteNote(forUser userId: String, tripId: String, noteId: String)
    func toggleFavourite(forUser userId: String, tripId: String, noteId: String, isFavourite: Bool)
    
}

class FireBaseService: FireBaseServiceProtocol {
    
    // MARK: Private properties
    
    private lazy var db = Firestore.firestore()
    private lazy var usersRef = db.collection("users")

    // MARK: Trip methods
    
    func fetchTrips(forUser id: String, completion: @escaping (Result <[Trip], FireBaseError>) -> Void) {
        usersRef.document(id).collection("trips").getDocuments() { (querySnapshot, err) in
            if err != nil {
                completion(.failure(FireBaseError.trip))
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
    
    func addTrip(forUser userId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void) {
        
        let newTripRef = usersRef.document(userId).collection("trips").document()
        newTripRef.setData([
            "id": newTripRef.documentID,
            "country": country,
            "currency": currency,
            "description": description,
            "beginningDate": beginningDate,
            "finishingDate": finishingDate
        ]) { err in
            if err != nil {
                errorCompletion()
            } else {
                completion(newTripRef.documentID)
            }
        }
    }
    
    func downloadTrip(forUser userId: String, tripId: String, completion: @escaping (Result <Trip, FireBaseError>) -> Void) {
        let tripRef = usersRef.document(userId).collection("trips").document(tripId)
        tripRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let trip = Trip(document: document)
                completion(.success(trip))
            } else {
                completion(.failure(FireBaseError.trip))
            }
        }
    }
    
    func updateTrip(forUser userId: String, tripId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void) {
        let tripRef = usersRef.document(userId).collection("trips").document(tripId)
        tripRef.updateData([
            "country": country,
            "beginningDate": beginningDate,
            "finishingDate": finishingDate,
            "description": description,
            "currency": currency
        ]) { err in
            if err != nil {
                errorCompletion()
            } else {
                completion(tripRef.documentID)
            }
        }
    }
    
    func deleteTrip(forUser userId: String, tripId: String, errorCompletion: @escaping () -> Void) {
        let tripRef = usersRef.document(userId).collection("trips").document(tripId)
        let noteCollectionRef = usersRef.document(userId).collection("trips").document(tripId).collection("tripNotes")
        tripRef.delete()
        noteCollectionRef.getDocuments { (snaphot, error) in
            if error != nil {
                errorCompletion()
            } else {
                for doc in snaphot!.documents {
                    let docref = self.usersRef.document(userId).collection("trips").document(tripId).collection("tripNotes").document(doc.documentID)
                    docref.delete()
                }
            }
        }
    }
    
    // MARK: Note methods
        
    func fetchNotes(forUser userId: String, forTrip tripId: String, completion: @escaping (Result <[TripNote], FireBaseError>) -> Void) {
        usersRef.document(userId).collection("trips").document(tripId).collection("tripNotes").getDocuments { (querySnapshot, error) in
            if error != nil {
                completion(.failure(FireBaseError.note))
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
    
    func fetchFavouriteNotes(forUser userId: String, completion: @escaping (Result <[TripNote: Trip], FireBaseError>) -> Void) {
        usersRef.document(userId).collection("trips").getDocuments { (querySnapshot, error) in
            if error != nil {
                completion(.failure(FireBaseError.note))
            } else {
                var tripNoteDict = [TripNote: Trip]()
                
                for document in querySnapshot!.documents {
                    let trip = Trip(snapshot: document)
                    
                    self.usersRef.document(userId).collection("trips").document(trip.id).collection("tripNotes").whereField("isFavourite", isEqualTo: true).getDocuments { (snapshot, error) in
                        if error != nil {
                            completion(.failure(FireBaseError.note))
                        } else {
                            
                        for document in snapshot!.documents {
                                let note = TripNote(document: document)
                                tripNoteDict[note] = trip
                            }
                            completion(.success(tripNoteDict))
                        }
                    }
                }
            }
        }
    }
    
    func addNote(forUser userId: String, tripId: String, category: String, city: String, price: Double, isFavourite: Bool, description: String, address: String, errorCompletion: @escaping () -> Void) {
        
        let newNoteRef = usersRef.document(userId).collection("trips").document(tripId).collection("tripNotes").document()
        newNoteRef.setData([
            "id": newNoteRef.documentID,
            "city": city,
            "category": category,
            "description": description,
            "price": price,
            "isFavourite": isFavourite,
            "date": Date(),
            "address": address
        ]) { err in
            if err != nil {
                errorCompletion()
            }
        }
    }
    
    func downloadNote(forUser userId: String, tripId: String, noteId: String, completion: @escaping (Result <TripNote, FireBaseError>) -> Void) {
        let noteRef = usersRef.document(userId).collection("trips").document(tripId).collection("tripNotes").document(noteId)
        noteRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let note = TripNote(document: document)
                completion(.success(note))
               } else {
                completion(.failure(FireBaseError.note))
               }
        }
    }
    
    func updateNote(forUser userId: String, tripId: String, noteId: String, city: String, category: String, description: String, price: Double, address: String, errorCompletion: @escaping () -> Void) {
        let noteRef = usersRef.document(userId).collection("trips").document(tripId).collection("tripNotes").document(noteId)
        noteRef.updateData([
            "city": city,
            "price": price,
            "description": description,
            "category": category,
            "address": address
        ]) { err in
            if err != nil {
                errorCompletion()
            }
        }
    }
     
    func toggleFavourite(forUser userId: String, tripId: String, noteId: String, isFavourite: Bool) {
        let noteRef = usersRef.document(userId).collection("trips").document(tripId).collection("tripNotes").document(noteId)
        
        noteRef.updateData(["isFavourite" : isFavourite])
    }
    
    func deleteNote(forUser userId: String, tripId: String, noteId: String) {
        let noteRef = usersRef.document(userId).collection("trips").document(tripId).collection("tripNotes").document(noteId)
        noteRef.delete()
    }
}

