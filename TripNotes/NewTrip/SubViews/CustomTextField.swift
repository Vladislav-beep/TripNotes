//
//  CustomTextField.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.12.2021.
//

import UIKit


class CustomTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        borderStyle = UITextField.BorderStyle.roundedRect
        backgroundColor = .tripGrey
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.tripGrey.cgColor
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
