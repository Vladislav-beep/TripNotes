//
//  DateFormatterService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

protocol nameDateFormatterServiceProtocol {
    func formatTripDate(date: String) -> String
}

class DateFormatterService {
    
    private let dateFormatter = DateFormatter()
    
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
    
    
    
    
    
    
    
//    func formatTripDate(date: String) -> String {
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
//            guard let backendDate = dateFormatter.date(from: date) else { return ""}
//
//            let formatDate = DateFormatter()
//            formatDate.dateFormat = "dd-MM-yyyy"
//            let date = formatDate.string(from: backendDate)
//            return date
//        }
    
}


