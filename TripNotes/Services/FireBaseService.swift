//
//  FireBaseService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.02.2022.
//

import Foundation
import Firebase

protocol FireBaseServiceProtocol {
    var userId: String { get }
    init(userId: String)
    func listenToTrips()
}

class FireBaseService: FireBaseServiceProtocol {
    
    var userId: String
    var tripsArray = [Trip]()
    
    private lazy var db = Firestore.firestore()
    private lazy var tripsRef = db.collection("users").document(userId).collection("trips")
    
    required init(userId: String) {
        self.userId = userId
    }
    
    func listenToTrips() {
        tripsRef.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                self.tripsArray.removeAll()
                for document in snapshot.documents {
                    
                    let data = document.data()
                    let beginningDate = (data["biginningDate"] as? Timestamp)?.dateValue()
                    let finishingDate = (data["finishingDate"] as? Timestamp)?.dateValue()
                    let trip = Trip(country: data["country"] as? String ?? "",
                                    beginningDate: beginningDate ?? Date(),
                                    finishingDate: finishingDate ?? Date(),
                                    description: data["description"] as? String ?? "",
                                    currency: .dollar,
                                    tripNotes: [data["tripNotes"]] as? [TripNote] ?? [],
                                    avatarTrip: nil)
                    
                    self.tripsArray.append(trip)
                }
                print(self.tripsArray)
            }
        }
        
    }
}

