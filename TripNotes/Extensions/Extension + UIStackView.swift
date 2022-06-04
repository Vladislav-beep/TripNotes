//
//  Extension UIStackView.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 18.12.2021.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func statisticsStackView(withImage image: String, withText text: String) -> UIStackView {
        
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: image)
            imageView.tintColor = .tripBlue
            imageView.contentMode = .scaleAspectFill
            imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        lazy var label: UILabel = {
            let label = UILabel()
            label.text = text
            label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            label.textColor = .tripBlue
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let stack = UIStackView(arrangedSubviews: [imageView, label],
                                axis: .horizontal,
                                spacing: 10,
                                distribution: .fillProportionally)
        return stack
    }
}
