//
//  LikeButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.03.2022.
//

import UIKit

class LikeButton: UIButton {
    
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
        setBackgroundImage(UIImage(systemName: C.ImageNames.likeHeart.rawValue), for: .normal)
        tintColor = .tripGrey
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.3
        translatesAutoresizingMaskIntoConstraints = false
    }
}
