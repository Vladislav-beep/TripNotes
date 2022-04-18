//
//  BackButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.03.2022.
//

import UIKit

class BackButton: UIButton {
    
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
        let image = UIImage(systemName: C.ImageNames.back.rawValue)
        tintColor = .tripWhite
        setBackgroundImage(image, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
