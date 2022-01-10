//
//  Extension + UIView.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 09.01.2022.
//

import UIKit

extension UIView {
    
    func setupBackGroundColor(forCategory category: Category) {
        switch category {
        case .hotels:
            backgroundColor = .lightGray
        case .tranport:
            backgroundColor = .tripBlue
        case .foodAndRestaurants:
            backgroundColor = .tripRed
        case .activity:
            backgroundColor = .tripYellow
        case .purchases:
            backgroundColor = .systemPink
        case .other:
            backgroundColor = .cyan
        }
    }
}
