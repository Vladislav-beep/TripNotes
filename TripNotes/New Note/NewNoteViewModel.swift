//
//  NewNoteViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.01.2022.
//

import Foundation

protocol NewNoteViewModelProtocol {
    var category: String { get }
    var city: String { get }
    var price: String { get }
    var description: String { get }
    var address: String { get }
    var noteCompletion: (() -> Void)? { get set }
    var errorCompletion: ((FireBaseError) -> Void)? { get set }
    init(userId: String, tripId: String, noteId: String, fireBaseService: FireBaseServiceProtocol)
    func addNote(category: String, city: String, price: Double, isFavourite: Bool, description: String, address: String, errorCompletion: @escaping () -> Void)
    func updateNote(city: String, category: String, description: String, price: Double, address: String, errorCompletion: @escaping () -> Void)
    func downloadNote()
}

class NewNoteViewModel: NewNoteViewModelProtocol {
    
    // MARK: - Dependencies

    private let fireBaseService: FireBaseServiceProtocol
    
    // MARK: - Private properties
    
    private var note: TripNote?
    
    // MARK: - Properties
    
    var tripId: String
    var noteId: String
    var userId: String
    var noteCompletion: (() -> Void)?
    var errorCompletion: ((FireBaseError) -> Void)?
    
    var category: String {
        note?.category ?? "Other"
    }
    
    var city: String {
        note?.city ?? ""
    }
    
    var price: String {
        String(note?.price ?? 0.0)
    }
    
    var description: String {
        note?.description ?? ""
    }
    
    var address: String {
        note?.address ?? ""
    }
    
    // MARK: - Life Time
    
    required init(userId: String, tripId: String, noteId: String, fireBaseService: FireBaseServiceProtocol) {
        self.userId = userId
        self.tripId = tripId
        self.noteId = noteId
        self.fireBaseService = fireBaseService
    }
    
    // MARK: - Methods
    
    func addNote(category: String, city: String, price: Double, isFavourite: Bool, description: String, address: String, errorCompletion: @escaping () -> Void) {
        fireBaseService.addNote(forUser: userId, tripId: tripId, category: category, city: city, price: price, isFavourite: isFavourite, description: description, address: address, errorCompletion: errorCompletion)
    }
    
    func downloadNote() {
        fireBaseService.downloadNote(forUser: userId, tripId: tripId, noteId: noteId) { [weak self] (result: Result<TripNote, FireBaseError>)  in
            switch result {
            case .success(let note):
                self?.note = note
                self?.noteCompletion?()
            case .failure(let error):
                self?.errorCompletion?(error)
            }
        }
    }
    
    func updateNote(city: String, category: String, description: String, price: Double, address: String, errorCompletion: @escaping () -> Void) {
        fireBaseService.updateNote(forUser: userId, tripId: tripId, noteId: note?.id ?? "", city: city, category: category, description: description, price: price, address: address, errorCompletion: errorCompletion)
    }
}
