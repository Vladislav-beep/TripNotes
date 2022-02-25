//
//  FireBaseService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.02.2022.
//

import Foundation
import Firebase

protocol FireBaseServiceProtocol {
    func listenToTrips() -> [Trip]
}

class FireBaseService {
    
    
    var tripsArray = [Trip]()
    private lazy var db = Firestore.firestore()
    
        
//    func listenToTrips() -> [Trip] {
//        let tripsRef = db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips")
//        var _tripsArray = [Trip]()
//        tripsRef.addSnapshotListener { (snapshot, error) in
//
//
//
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            if let snapshot = snapshot {
//                _tripsArray.removeAll()
//
//                for document in snapshot.documents {
//                    let data = document.data()
//                    let beginningDate = (data["biginningDate"] as? Timestamp)?.dateValue()
//                    let finishingDate = (data["finishingDate"] as? Timestamp)?.dateValue()
//                    let trip = Trip(country: data["country"] as? String ?? "",
//                                    beginningDate: beginningDate ?? Date(),
//                                    finishingDate: finishingDate ?? Date(),
//                                    description: data["description"] as? String ?? "",
//                                    currency: .dollar,
//                                    tripNotes: [data["tripNotes"]] as? [TripNote] ?? [],
//                                    avatarTrip: nil)
//                    print("\(trip) - tripCaca")
//
//                    _tripsArray.append(trip)
//                    print("\(self.tripsArray) - into")
//                }
//                self.tripsArray = _tripsArray
//                print("\(self.tripsArray) - 1")
//            }
//            print("\(self.tripsArray) - 2")
//        }
//        print("\(self.tripsArray) - 3")
//        return _tripsArray
//    }
    func listenToTrips(forUser id: String, completion: @escaping (Result <[Trip], Error>) -> Void) {
        
        db.collection("users").document("NUXiX5zSMiwYxmtCBpzO").collection("trips").getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(.failure(err.localizedDescription as! Error))
            } else {
                
                var tripArray = [Trip]()
                for document in querySnapshot!.documents {
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
                    tripArray.append(trip)
                    
                }
                
                completion(.success(tripArray))
                print("\(tripArray) - from service")
            }
        }
    }
}

