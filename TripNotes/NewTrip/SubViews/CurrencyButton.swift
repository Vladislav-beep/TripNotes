//
//  CurrencyButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 23.12.2021.
//

import UIKit

class CurrencyButton: UIButton {
    
    private var title: String?
    private var fontSize: CGFloat?
    private var selectedBackgroundColor: UIColor?
    private var defaultBackgroundColor: UIColor? {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }
    
    init(title: String?, fontSize: CGFloat?) {
        self.title = title
        self.fontSize = fontSize
        super.init(frame: .zero)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
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
    
    enum ButtonState {
        case normal
        case selected
    }
    
    // change background color on isSelected value changed
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
    
    // set color for different state
    func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
        switch state {
        case .selected:
            selectedBackgroundColor = color
        case .normal:
            defaultBackgroundColor = color
        }
    }
    
    func setImage(imageName: String) {
        setBackgroundImage(UIImage(systemName: imageName), for: .normal)
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
