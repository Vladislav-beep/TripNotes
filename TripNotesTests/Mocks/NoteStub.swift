//
//  NoteStub.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 21.05.2022.
//

import Foundation

class NoteStub {
    
    func getNotes() -> [TripNote] {
        return [
            TripNote(id: "0987654",
                         city: "Moscow",
                         category: "Food",
                         price: 78.35,
                         date: Date(),
                         description: "Went to cafe",
                         isFavourite: false,
                         address: "Puschin street"),
            TripNote(id: "1234567",
                     city: "Paris",
                     category: "Transport",
                     price: 2.56,
                     date: Date(),
                     description: "Bus ride",
                     isFavourite: true,
                     address: "Elesei fields")
        ]
    }
}
