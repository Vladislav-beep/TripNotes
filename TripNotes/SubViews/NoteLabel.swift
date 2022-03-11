//
//  NoteLabel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 05.02.2022.
//

import UIKit

class NoteLabel: UILabel {
    
    // MARK: Private properties
   
    private let fontSize: CGFloat
    private let fontWeight: UIFont.Weight
    
    // MARK: Life Time
    
    init(fontSize: CGFloat, fontWeight: UIFont.Weight) {
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialize() {
        textColor = .tripBlue
        textAlignment = .left
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
