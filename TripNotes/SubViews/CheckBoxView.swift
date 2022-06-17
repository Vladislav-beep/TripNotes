//
//  CheckBoxView.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 17.06.2022.
//

import UIKit

final class CheckBoxView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tripRed
        imageView.layer.cornerRadius = 5
        imageView.tintColor = .tripGrey
        imageView.image = UIImage(systemName: "checkmark.rectangle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        layer.borderWidth = 3
        layer.borderColor = UIColor.tripBlue.cgColor
        
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        
        setupImageView()
    }
    
    private func setupImageView() {
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
