//
//  WarningLabel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 10.03.2022.
//

import UIKit

class WarningLabel: UILabel {
    
    // MARK: Private methods
    
    let fontSize: CGFloat
    
    // MARK: Life time
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialize() {
        text = ""
        font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        textColor = .tripRed
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
