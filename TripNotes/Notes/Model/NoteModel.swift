//
//  NoteModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

struct TripNote {
    let city: String
    let category: Category
    let price: Double
    let date: Date
    let description: String?
    let isFavoutite: Bool
    let adress: String?
}
