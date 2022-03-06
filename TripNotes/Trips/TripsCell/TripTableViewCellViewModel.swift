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
    func getTotalSum() -> String
   // func downloadNotes()
    var notesCompletion: (() -> Void)? { get set }
    init(trip: Trip)
}


class TripTableViewCellViewModel: TripTableViewCellViewModelProtocol {

    // MARK: Properties
    
    let fire = FireBaseService()
    
    let image = "placeHolder1"
    
    var description: String {
        trip.description
    }
    
    var date: String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        
        let bdate = dateformatter.string(from: trip.beginningDate)
        let fdate = dateformatter.string(from: trip.finishingDate)
        return "\(bdate) - \(fdate)"
    }
    
    var country: String {
        trip.country
    }
    
    var notesCompletion: (() -> Void)?
    
    // MARK: Private properties
    
    private let trip: Trip
    
    // MARK: Life Time
    
    required init(trip: Trip) {
        self.trip = trip
    }
    
    // MARK: Methods
    
//    func downloadNotes() {
//        fire.listenToNotes(forTrip: trip.id, completion: { (result: Result<[TripNote], Error>) in
//            switch result {
//            case .success(let notess):
//                self.notes = notess
//                self.notesCompletion?()
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        })
//    }
    
    
    func getTotalSum() -> String {
        let totalSum: Double = 0.0
        let stringTotal = String(totalSum)
//        for note in notes {
//            totalSum += Double(note.price)
//            print(notes)
//        }
//
//        let formattedTotalSum = totalSum.formattedWithSeparator
//        let returnTotalSum = "\(formattedTotalSum) \(trip.currency)"
        return stringTotal
    }
}
