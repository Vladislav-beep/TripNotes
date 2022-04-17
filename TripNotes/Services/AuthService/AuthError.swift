//
//  AuthError.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 17.04.2022.
//

enum AuthError: Error {
    case badURL
    case badData
    case networkProblem
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad URL"
        case .badData:
            return "No data"
        case .networkProblem:
            return "Network problem"
        }
    }
}
