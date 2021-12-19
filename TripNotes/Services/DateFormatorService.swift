//
//  DateFormatorService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

protocol nameDateFormatterServiceProtocol {
    func formatTripDate(date: String) -> String
}

class DateFormatterService {
    
    func formatTripDate(date: String) -> String {
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            guard let backendDate = dateFormatter.date(from: date) else { return ""}
            
            let formatDate = DateFormatter()
            formatDate.dateFormat = "dd-MM-yyyy"
            let date = formatDate.string(from: backendDate)
            return date
        }
    
}


