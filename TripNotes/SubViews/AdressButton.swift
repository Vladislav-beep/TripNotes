//
//  AdressButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.03.2022.
//

import UIKit

class AdressButton: UIButton {
    
    // MARK: Life Time
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialize() {
        setTitle(" Address", for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        tintColor = .tripBlue
        setTitleColor(.tripBlue, for: .normal)
        backgroundColor = .tripGrey
        setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 5)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
