//
//  NoteModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation
import Firebase

struct TripNote: Hashable {
    let id: String
    let city: String
    let category: String
    let price: Double
    let date: Date
    let description: String?
    let isFavourite: Bool
    let adress: String?
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data()
        id = snapshotValue["id"] as? String ?? ""
        city = snapshotValue["city"] as? String ?? ""
        category = snapshotValue["category"] as? String ?? ""
        price = snapshotValue["price"] as? Double ?? 0.0
        date = (snapshotValue["date"] as? Timestamp)?.dateValue() ?? Date()
        description = snapshotValue["description"] as? String ?? ""
        isFavourite = snapshotValue["isFavourite"] as? Bool ?? false
        adress = snapshotValue["adress"] as? String ?? ""
    }
    
    init(document: DocumentSnapshot) {
        let snapshotValue = document.data()
        id = snapshotValue?["id"] as? String ?? ""
        city = snapshotValue?["city"] as? String ?? ""
        category = snapshotValue?["category"] as? String ?? ""
        price = snapshotValue?["price"] as? Double ?? 0.0
        date = (snapshotValue?["date"] as? Timestamp)?.dateValue() ?? Date()
        description = snapshotValue?["description"] as? String ?? ""
        isFavourite = snapshotValue?["isFavourite"] as? Bool ?? false
        adress = snapshotValue?["adress"] as? String ?? ""
    }
    
    init(id: String, city: String, category: String, price: Double, date: Date, description: String, isFavourite: Bool, adress: String) {
        self.id = id
        self.city = city
        self.category = category
        self.price = price
        self.date = date
        self.description = description
        self.isFavourite = isFavourite
        self.adress = adress
        
    }
}
