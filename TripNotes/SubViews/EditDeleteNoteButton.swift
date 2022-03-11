//
//  EditDeleteNoteButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.03.2022.
//

import UIKit

class EditDeleteNoteButton: UIButton {
    
    // MARK: Private Properties
    
    private let title: String
    private let imageName: String
    private let backgroud: UIColor
    
    // MARK: Life Time
    
    init(title: String, imageName: String, backgroud: UIColor) {
        self.title = title
        self.imageName = imageName
        self.backgroud = backgroud
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialize() {
        setTitle(title, for: .normal)
        setImage(UIImage(systemName: imageName), for: .normal)
        tintColor = .tripWhite
        backgroundColor = backgroud
        layer.cornerRadius = 4
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
