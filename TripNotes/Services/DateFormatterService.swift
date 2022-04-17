//
//  DateFormatterService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

protocol DateFormatterServiceProtocol {
    func convertTripDateToString(date: Date) -> String
    func convertTripDateToShortString(date: Date) -> String
    func convertNoteDateToString(date: Date) -> String
}

class DateFormatterService: DateFormatterServiceProtocol {
    
    // MARK: - Private properties
    
    private let dateFormatter = DateFormatter()
    
    // MARK: - Methods
    
    func convertTripDateToString(date: Date) -> String {
        dateFormatter.dateStyle = .medium
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    func convertTripDateToShortString(date: Date) -> String {
        dateFormatter.dateFormat = "dd.MM.yy"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    func convertNoteDateToString(date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm, dd.MM.yy"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}
