//
//  FireBaseServiceMock.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 19.05.2022.
//

import Foundation

class FireBaseServiceMock: FireBaseServiceProtocol {
    
    // MARK: Private
    
    private var trips = TripStub().getTripsStub()
    private var notes = NoteStub().getNotes()
    
    // MARK: Public
    
    func fetchTrips(forUser id: String, completion: @escaping (Result<[Trip], FireBaseError>) -> Void) {
        completion(.success(trips))
    }
    
    func addTrip(forUser userId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void) {
        
    }
    
    func downloadTrip(forUser userId: String, tripId: String, completion: @escaping (Result<Trip, FireBaseError>) -> Void) {
        
    }
    
    func updateTrip(forUser userId: String, tripId: String, country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void) {
        
    }
    
    func deleteTrip(forUser userId: String, tripId: String, errorCompletion: @escaping () -> Void) {
        trips.remove(at: 0)
    }
    
    func fetchNotes(forUser userId: String, forTrip tripId: String, completion: @escaping (Result<[TripNote], FireBaseError>) -> Void) {
        completion(.success(notes))
    }
    
    func fetchFavouriteNotes(forUser userId: String, completion: @escaping (Result<[TripNote : Trip], FireBaseError>) -> Void) {
        
    }
    
    func addNote(forUser userId: String, tripId: String, category: String, city: String, price: Double, isFavourite: Bool, description: String, address: String, errorCompletion: @escaping () -> Void) {
        
    }
    
    func downloadNote(forUser userId: String, tripId: String, noteId: String, completion: @escaping (Result<TripNote, FireBaseError>) -> Void) {
        
    }
    
    func updateNote(forUser userId: String, tripId: String, noteId: String, city: String, category: String, description: String, price: Double, address: String, errorCompletion: @escaping () -> Void) {
        
    }
    
    func deleteNote(forUser userId: String, tripId: String, noteId: String) {
        notes.remove(at: 0)
    }
    
    func toggleFavourite(forUser userId: String, tripId: String, noteId: String, isFavourite: Bool) {
            
        }
    }
