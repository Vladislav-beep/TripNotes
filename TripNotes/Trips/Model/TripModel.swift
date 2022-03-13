//
//  TripModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 14.12.2021.
//

import Foundation
import Firebase

struct Trip: Equatable {
    let id: String
    let country: String
    let beginningDate: Date
    let finishingDate: Date
    let description: String
    let currency: String
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data()
        id = snapshotValue["id"] as? String ?? ""
        country = snapshotValue["country"] as? String ?? ""
        beginningDate = (snapshotValue["beginningDate"] as? Timestamp)?.dateValue() ?? Date()
        finishingDate = (snapshotValue["finishingDate"] as? Timestamp)?.dateValue() ?? Date()
        description = snapshotValue["description"] as? String ?? ""
        currency = snapshotValue["currency"] as? String ?? ""
    }
    
    init(document: DocumentSnapshot) {
        let snapshotValue = document.data()
        id = snapshotValue?["id"] as? String ?? ""
        country = snapshotValue?["country"] as? String ?? ""
        beginningDate = (snapshotValue?["beginningDate"] as? Timestamp)?.dateValue() ?? Date()
        finishingDate = (snapshotValue?["finishingDate"] as? Timestamp)?.dateValue() ?? Date()
        description = snapshotValue?["description"] as? String ?? ""
        currency = snapshotValue?["currency"] as? String ?? ""
    }
    
    init(id: String, country: String, beginningDate: Date, finishingDate: Date, description: String, currency: String) {
        self.id = id
        self.country = country
        self.beginningDate = beginningDate
        self.finishingDate = finishingDate
        self.description = description
        self.currency = currency
    }
    
//    func convertToDictionary() -> Any {
//        return ["title": title, "userId": userId, "completed": completed]
//    }
}

