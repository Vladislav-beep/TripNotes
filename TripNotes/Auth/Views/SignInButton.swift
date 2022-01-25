//
//  SignInButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 24.01.2022.
//

import UIKit

class SignInButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setTitle("Sign in", for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        backgroundColor = .tripRed
        layer.cornerRadius = 12
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 3)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
