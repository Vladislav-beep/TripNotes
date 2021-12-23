//
//  CurrencyButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 23.12.2021.
//

import UIKit

class CurrencyButton: UIButton {
    
    var title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        backgroundColor = .tripGrey
        setTitleColor(.darkGray, for: .normal)
        setTitle(title, for: .normal)
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.font = .systemFont(ofSize: 30, weight: .medium)
        titleLabel?.minimumScaleFactor = 0.1
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.5
    
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
