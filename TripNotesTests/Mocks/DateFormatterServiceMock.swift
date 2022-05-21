//
//  DateFormatterServiceMock.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 19.05.2022.
//

import Foundation

class DateFormatterServiceMock: DateFormatterServiceProtocol {
    
    // MARK: Public
    
    func convertTripDateToString(date: Date) -> String {
        return "14 Sep 2022"
    }
    
    func convertTripDateToShortString(date: Date) -> String {
        return ""
    }
    
    func convertNoteDateToString(date: Date) -> String {
        return ""
    }
}
