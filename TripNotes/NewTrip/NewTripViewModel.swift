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
    init(tripId: String)
    func addTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date)
    func updateTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date)
    func downloadTrip()
}

class NewTripViewModel: NewTripViewModelProtocol {
    
    let fire = FireBaseService()
    
    // MARK: Private proaperties
    
    private var trip: Trip?
    
    // MARK: Properties
    
    var tripId: String
    
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
    
    // MARK: Life Time
    
    required init(tripId: String) {
        self.tripId = tripId
    }
    
    // MARK: Methods
    
    func addTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date) {
        fire.addTrip(country: country, currency: currency, description: description, beginningDate: beginningDate, finishingDate: finishingDate)
    }
    
    func downloadTrip() {
        fire.downloadTrip(tripId: tripId) { (result: Result<Trip, Error>)  in
            switch result {
            case .success(let tripp):
                self.trip = tripp
                self.tripCompletion?()
            case .failure(let error):
                print("\(error.localizedDescription) - JJJJJJJJJJJ")
                return
            }
        }
    }
    
    func updateTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date) {
        fire.updateTrip(tripId: tripId, country: country, currency: currency, description: description, beginningDate: beginningDate, finishingDate: finishingDate)
    }
}


