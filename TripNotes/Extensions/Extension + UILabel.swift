//
//  Extension + UILabel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 10.01.2022.
//

import UIKit

extension UILabel {
    
    func setupTintColor(forCategory category: Category) {
        switch category {
        case .hotels:
            textColor = .tripWhite
        case .tranport:
            textColor = .tripWhite
        case .foodAndRestaurants:
            textColor = .tripWhite
        case .activity:
            textColor = .tripBlue
        case .purchases:
            textColor = .tripWhite
        case .other:
            textColor = .tripWhite
        }
    }
}
