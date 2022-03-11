//
//  NoLabel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.03.2022.
//

import UIKit

class NoLabel: UILabel {
    
    // MARK: Private properties
    
    private let title: String
    
    // MARK: Life Time
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialize() {
        text = title
        textColor = .tripRed
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
