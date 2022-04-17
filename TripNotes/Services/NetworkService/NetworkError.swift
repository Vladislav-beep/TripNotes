//
//  NetworkError.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 29.03.2022.
//

enum NetworkError: Error {
    case badURL
    case badData
    case networkProblem
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Something wrong with network"
        case .badData:
            return "Couldn't get data. Try later."
        case .networkProblem:
            return "Something wrong with network. Check internet connection"
        }
    }
}
