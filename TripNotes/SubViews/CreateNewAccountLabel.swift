//
//  CreateNewAccountLabel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 10.03.2022.
//

import UIKit

class CreateNewAccountLabel: UILabel {
    
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
        numberOfLines = 1
        text = I.CreateNewAccountLabelText
        textAlignment = .center
        textColor = .tripBlue
        adjustsFontSizeToFitWidth = true
        font = UIFont.systemFont(ofSize: 30, weight: .regular)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
