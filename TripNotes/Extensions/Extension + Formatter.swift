//
//  Extension + Formatter.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = " "
        return formatter
    }()
}
