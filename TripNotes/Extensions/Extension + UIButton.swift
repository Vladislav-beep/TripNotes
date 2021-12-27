//
//  Extension + UIButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 27.12.2021.
//

import UIKit

extension UIButton {
    
    func showAnimatedly() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 1
        pulse.toValue = 0
        pulse.duration = 3
        pulse.autoreverses = false
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.5
        pulse.damping = 0.5
        layer.add(pulse, forKey: nil)
    }
    
    func hideAnimatedly() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0
        pulse.toValue = 1
        pulse.duration = 1
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 0.5
        layer.add(pulse, forKey: nil)
    }
    
}
