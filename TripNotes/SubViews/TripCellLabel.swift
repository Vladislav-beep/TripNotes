//
//  TripCellLabel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 10.03.2022.
//

import UIKit

class TripCellLabel: UILabel {
    
    // MARK: Private properties
    
    private let lineNumber: Int
    private let fontSize: CGFloat
    
    // MARK: Life time
    
    init(lineNumber: Int, fontSize: CGFloat) {
        self.lineNumber = lineNumber
        self.fontSize = fontSize
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialize() {
        textColor = .tripWhite
        numberOfLines = lineNumber
        font = UIFont.boldSystemFont(ofSize: fontSize)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
