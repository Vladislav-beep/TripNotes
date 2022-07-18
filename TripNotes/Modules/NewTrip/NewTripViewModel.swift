//
//  NewTripViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.12.2021.
//

import Foundation

protocol NewTripViewModelProtocol {
    var tripId: String { get }
    var country: String { get }
    var beginningDate: String { get }
    var finishingDate: String { get }
    var description: String { get }
    var currency: String { get }
    var tripCompletion: (() -> Void)? { get set }
    var errorCompletion: ((FireBaseError) -> Void)? { get set }
    init(tripId: String, userId: String,
         fireBaseService: FireBaseServiceProtocol,
         fileStorageService: FileStorageServiceProtocol)
    func saveImage(data: Data, key: String)
    func retrieveImage() -> Data
    func deleteImage(forKey key: String)
    func addTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void) 
    func updateTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void)
    func downloadTrip()
}

class NewTripViewModel: NewTripViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let fireBaseService: FireBaseServiceProtocol
    private let fileStorageService: FileStorageServiceProtocol
    
    // MARK: - Private properties
    
    private var trip: Trip?
    
    // MARK: - Properties
    
    var tripId: String
    var userId: String
    
    var country: String {
        trip?.country ?? ""
    }
    
    var beginningDate: String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        
        return dateformatter.string(from: trip?.beginningDate ?? Date())
    }
    
    var finishingDate: String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        
        return dateformatter.string(from: trip?.finishingDate ?? Date())
    }
    
    var description: String {
        trip?.description ?? ""
    }
    
    var currency: String {
        trip?.currency ?? ""
    }
    
    var tripCompletion: (() -> Void)?
    var errorCompletion: ((FireBaseError) -> Void)?
    
    // MARK: - Life Time
    
    required init(tripId: String, userId: String, fireBaseService: FireBaseServiceProtocol, fileStorageService: FileStorageServiceProtocol) {
        self.userId = userId
        self.tripId = tripId
        self.fireBaseService = fireBaseService
        self.fileStorageService = fileStorageService
    }
    
    // MARK: - Methods
    
    func saveImage(data: Data, key: String) {
        fileStorageService.store(image: data, forKey: key)
    }
    
    func retrieveImage() -> Data {
        fileStorageService.retrieveImage(forKey: tripId) ?? Data()
    }
    
    func deleteImage(forKey key: String) {
        fileStorageService.delete(forKey: key)
    }
    
    func addTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void) {
        fireBaseService.addTrip(forUser: userId, country: country, currency: currency, description: description, beginningDate: beginningDate, finishingDate: finishingDate, completion: completion, errorCompletion: errorCompletion)
    }
    
    func downloadTrip() {
        fireBaseService.downloadTrip(forUser: userId, tripId: tripId) { [weak self] (result: Result<Trip, FireBaseError>)  in
            switch result {
            case .success(let tripp):
                self?.trip = tripp
                self?.tripCompletion?()
            case .failure(let error):
                self?.errorCompletion?(error)
                return
            }
        }
    }
    
    func updateTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date, completion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void) {
        fireBaseService.updateTrip(forUser: userId, tripId: tripId, country: country, currency: currency, description: description, beginningDate: beginningDate, finishingDate: finishingDate, completion: completion, errorCompletion: errorCompletion)
    }
}
