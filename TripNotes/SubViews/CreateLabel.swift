//
//  CreateLabel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 10.03.2022.
//

import UIKit

class CreateLabel: UILabel {
    
    // MARK: Life time
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialize() {
        text = "I don't have an account"
        textAlignment = .center
        textColor = .tripBlue
        layer.opacity = 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }
}
