//
//  SignInButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 24.01.2022.
//

import UIKit

class SignInButton: UIButton {
    
    // MARK: Private properties
    
    private let title: String
    private let colorOfBackground: UIColor
    
    // MARK: Life Time
    
    init(title: String, colorOfBackground: UIColor) {
        self.title = title
        self.colorOfBackground = colorOfBackground
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialize() {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        backgroundColor = colorOfBackground
        layer.cornerRadius = 12
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 3)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
