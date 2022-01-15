//
//  SelectionLabel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 15.01.2022.
//

import UIKit

class SelectionLabel: UILabel {
   
    internal var labelText: String
    
    init(labelText: String) {
        self.labelText = labelText
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        text = labelText
        textColor = .tripBlue
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
