//
//  CustomTextField.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.12.2021.
//

import UIKit


class CustomTextField: UITextField {
    
    // MARK: Private properties
    
    private let imageName: String
    
    // MARK: Life Time
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
   private func initialize() {
        borderStyle = .none
        backgroundColor = .tripGrey
        font = UIFont.systemFont(ofSize: 18)
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.tripGrey.cgColor
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 5)
        
        let imageView = UIImageView(frame: CGRect(x: 6.0, y: 6.0, width: 28.0, height: 28.0))
        let image = UIImage(named: imageName)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .tripRed

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 40))
        view.addSubview(imageView)
        leftViewMode = .always
        leftView = view
    }
}
