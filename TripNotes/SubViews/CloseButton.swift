//
//  CloseButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 09.03.2022.
//

import UIKit

class CloseButton: UIButton {
    
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
    setBackgroundImage(UIImage(systemName: C.ImageNames.closeButton.rawValue), for: .normal)
        tintColor = .tripBlue
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }
}
