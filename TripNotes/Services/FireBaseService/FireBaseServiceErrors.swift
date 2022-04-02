//
//  FireBaseServiceErrors.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 29.03.2022.
//

import Foundation

enum FireBaseError: Error {
    case trip
    case note
    
    var errorDescription: String {
        switch self {
        case .trip:
            return "Something wrong with the Trip. Please, Check internet connection"
        case .note:
            return "Something wrong with your Note. Please, Check internet connection"
        }
    }
}
