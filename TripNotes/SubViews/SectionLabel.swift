//
//  sectionLabel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 16.01.2022.
//

import UIKit

class SectionLabel: UILabel {
    
    // MARK: Private properties
    
    private var labelText: String
    
    // MARK: Life Time
    
    init(labelText: String) {
        self.labelText = labelText
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func initialize() {
        text = labelText
        textColor = .tripRed
        font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
