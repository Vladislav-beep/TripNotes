//
//  TripTableViewCellViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 17.12.2021.
//

import Foundation

protocol TripTableViewCellViewModelProtocol {
    var country: String { get }
    var description: String { get }
    var date: String { get }
    var currency: String { get }
    var notesCompletion: (() -> Void)? { get set }
    init(fileStorageService: FileStorageServiceProtocol,
         dateFormatterService: DateFormatterServiceProtocol,
         trip: Trip)
    func retrieveImage() -> Data
}


class TripTableViewCellViewModel: TripTableViewCellViewModelProtocol {

    // MARK: - Dependencies
    
    private let fileStorageService: FileStorageServiceProtocol
    private let dateFormatterService: DateFormatterServiceProtocol

    // MARK: - Properties
    
    var description: String {
        trip.description
    }
    
    var date: String {
        let beginningDate = dateFormatterService.convertTripDateToString(date: trip.beginningDate)
        let finishingDate = dateFormatterService.convertTripDateToString(date: trip.finishingDate)
        return "\(beginningDate) - \(finishingDate)"
    }
    
    var country: String {
        trip.country
    }
    
    var currency: String {
        trip.currency
    }
    
    var notesCompletion: (() -> Void)?
    
    // MARK: - Private properties
    
    private let trip: Trip
    
    // MARK: - Life Time
    
    required init(fileStorageService: FileStorageServiceProtocol,
                  dateFormatterService: DateFormatterServiceProtocol,
                  trip: Trip) {
        self.fileStorageService = fileStorageService
        self.dateFormatterService = dateFormatterService
        self.trip = trip
    }
    
    // MARK: - Methods
    
    func retrieveImage() -> Data {
        return fileStorageService.retrieveImage(forKey: trip.id) ?? Data()
    }
}
