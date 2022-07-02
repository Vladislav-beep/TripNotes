//
//  CurrencyButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 23.12.2021.
//

import UIKit

class SelectionButton: UIButton {
    
    // MARK: Private properties
    
    private var title: String?
    private var fontSize: CGFloat?
    private var imageHeight: CGFloat?
    private var selectedBackgroundColor: UIColor?
    private var defaultBackgroundColor: UIColor? {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }
    
    // MARK: Overriden properties
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                if let color = selectedBackgroundColor {
                    self.backgroundColor = color
                }
            }
            else {
                if let color = defaultBackgroundColor {
                    self.backgroundColor = color
                }
            }
        }
    }
    
    // MARK: Enum
    
    enum ButtonState {
        case normal
        case selected
    }
    
    // MARK: UI
    
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Life Time
    
    init(title: String?, fontSize: CGFloat?, imageHeight: CGFloat? = 35) {
        self.title = title
        self.fontSize = fontSize
        self.imageHeight = imageHeight
        super.init(frame: .zero)
        initialize()
    }
    
    init(imageHeight: CGFloat? = 35) {
        self.imageHeight = imageHeight
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func initialize() {
        setBackgroundColor(.tripGrey, for: .normal)
        setBackgroundColor(.tripRed, for: .selected)
        setTitleColor(.tripBlue, for: .normal)
        tintColor = .tripBlue
        setTitle(title, for: .normal)
        
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.font = .systemFont(ofSize: fontSize ?? 15, weight: .medium)
        titleLabel?.minimumScaleFactor = 0.1
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.5
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
        switch state {
        case .selected:
            selectedBackgroundColor = color
        case .normal:
            defaultBackgroundColor = color
        }
    }
    
    func setImage(imageName: String) {
        self.addSubview(categoryImageView)
        NSLayoutConstraint.activate([
            categoryImageView.heightAnchor.constraint(equalToConstant: imageHeight ?? 0),
            categoryImageView.widthAnchor.constraint(equalToConstant: imageHeight ?? 0),
            categoryImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            categoryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        categoryImageView.contentMode = .scaleAspectFit
        categoryImageView.image = UIImage(systemName: imageName)
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0.97
        pulse.toValue = 1
        pulse.duration = 5
        pulse.autoreverses = true
        pulse.repeatCount = Float.greatestFiniteMagnitude
        pulse.initialVelocity = 0.5
        pulse.damping = 0.5
        layer.add(pulse, forKey: nil)
    }
    
    func stopAnimation() {
        layer.removeAllAnimations()
    }
}
