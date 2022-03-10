//
//  AddButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 10.03.2022.
//

import UIKit

class AddButton: UIButton {
    
    // MARK: Properties
    
    var imageName: String?
    var title: String?
    var cornerRadius: CGFloat
    
    // MARK: Life time
    
    init(imageName: String?, title: String?, cornerRadius: CGFloat) {
        self.imageName = imageName
        self.title = title
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialize() {
        setTitle(title, for: .normal)
        setImage(UIImage(systemName: imageName ?? ""), for: .normal)
        layer.cornerRadius = cornerRadius
        backgroundColor = .tripRed
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.5
        layer.shouldRasterize = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
