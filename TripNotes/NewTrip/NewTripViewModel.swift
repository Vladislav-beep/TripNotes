//
//  NewTripViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.12.2021.
//

import Foundation

protocol NewTripViewModelProtocol {
    func addTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date)
    func updateTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date)
    func downloadTrip()
    var tripId: String { get }
    var trip: Trip? { get }
    var tripCompletion: (() -> Void)? { get set }
    var country: String { get }
    var beginningDate: String { get }
    var finishingDate: String { get }
    var description: String { get }
    var currency: String { get }
    init(tripId: String)
}

class NewTripViewModel: NewTripViewModelProtocol {
      
    let fire = FireBaseService()
    
    var tripId: String
    var trip: Trip?
    
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
  
    
    required init(tripId: String) {
        self.tripId = tripId
    }
    
    func addTrip(country: String, currency: String, description: String, beginningDate: Date, finishingDate: Date) {
        fire.addTrip(country: country, currency: currency, description: description, beginningDate: beginningDate, finishingDate: finishingDate)
    }
    
    func downloadTrip() {
        fire.downloadTrip(tripId: tripId) { (result: Result<Trip, Error>)  in
            switch result {
            case .success(let tripp):
                self.trip = tripp
                self.tripCompletion?()
                print("AAAAAAAAAAAAA")
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


