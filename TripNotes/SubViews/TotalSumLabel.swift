//
//  TotalSumLabel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 10.03.2022.
//

import UIKit

class TotalSumLabel: UILabel {
    
    let fontSize: CGFloat
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        textColor = .tripBlue
        numberOfLines = 1
        font = UIFont.boldSystemFont(ofSize: fontSize)
        textAlignment = .right
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.2
        translatesAutoresizingMaskIntoConstraints = false
    }
}
