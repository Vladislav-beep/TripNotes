//
//  DateFormatterServiceMock.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 19.05.2022.
//

import Foundation

class DateFormatterServiceMock: DateFormatterServiceProtocol {
    
    func convertTripDateToString(date: Date) -> String {
        return ""
    }
    
    func convertTripDateToShortString(date: Date) -> String {
        return ""
    }
    
    func convertNoteDateToString(date: Date) -> String {
        return ""
    }
}
