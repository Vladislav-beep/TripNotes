//
//  StatisticsViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 03.06.2022.
//

import Foundation

protocol StatisticsViewModelProtocol {
    var trasportText: String { get }
    var hotelText: String { get }
    var foodText: String { get }
    var activityText: String { get }
    var purchasesText: String { get }
    var otherText: String { get }
    init(notes: [TripNote], currency: String)
}

final class StatisticsViewModel: StatisticsViewModelProtocol {
    
    // MARK: - Private properties
    
    private let notes: [TripNote]
    private let currency: String
    
    
    // MARK: - Properties
    
    var trasportText: String {
        var sum = 0.0
        for note in notes {
            if note.category == Category.transport.rawValue {
                sum += note.price
            }
        }
        return "Transport: \(sum.formattedWithSeparator) \(currency)"
    }
    
    var hotelText: String {
        var sum = 0.0
        for note in notes {
            if note.category == Category.hotels.rawValue {
                sum += note.price
            }
        }
        return "Hotels: \(sum.formattedWithSeparator) \(currency)"
    }
    
    var foodText: String {
        var sum = 0.0
        for note in notes {
            if note.category == Category.food.rawValue {
                sum += note.price
            }
        }
        return "Food: \(sum.formattedWithSeparator) \(currency)"
    }
    
    var activityText: String {
        var sum = 0.0
        for note in notes {
            if note.category == Category.activity.rawValue {
                sum += note.price
            }
        }
        return "Activity: \(sum.formattedWithSeparator) \(currency)"
    }
    
    var purchasesText: String {
        var sum = 0.0
        for note in notes {
            if note.category == Category.purchases.rawValue {
                sum += note.price
            }
        }
        return "Purchases: \(sum.formattedWithSeparator) \(currency)"
    }
    
    var otherText: String {
        var sum = 0.0
        for note in notes {
            if note.category == Category.other.rawValue {
                sum += note.price
            }
        }
        return "Other: \(sum.formattedWithSeparator) \(currency)"
    }
    
    
    // MARK: - Lifecycle
    
    init(notes: [TripNote], currency: String) {
        self.notes = notes
        self.currency = currency
    }
}
