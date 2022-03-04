//
//  NoteModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

struct TripNote: Hashable {
    let id: String
    let city: String
    let category: String
    let price: Double
    let date: Date
    let description: String?
    let isFavourite: Bool
    let adress: String?
}
