//
//  CustomTextField.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.12.2021.
//

import UIKit


class CustomTextField: UITextField {
    
    var imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(frame: .zero)
        
        borderStyle = UITextField.BorderStyle.roundedRect
        backgroundColor = .tripGrey
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.tripGrey.cgColor
        layer.masksToBounds = true
        
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(systemName: imageName)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        leftViewMode = .always
        leftView = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




