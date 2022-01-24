//
//  AuthTextField.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 24.01.2022.
//

import UIKit

class AuthTextField: UITextField {
    
    var placeHolder: String
    
    init(placeHolder: String) {
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        
        placeholder = placeHolder
        backgroundColor = .tripYellow
        textAlignment = .center
        textColor = .tripBlue
        font = UIFont.systemFont(ofSize: 19, weight: .regular)
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
    


