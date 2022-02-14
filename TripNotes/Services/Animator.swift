//
//  Animator.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 12.02.2022.
//

import UIKit

class Animator {
    let layoutConstraint: NSLayoutConstraint
    let container: UIView
    
    init(layoutConstraint: NSLayoutConstraint, container: UIView) {
        self.layoutConstraint = layoutConstraint
        self.container = container
    }
    
    func animate(completion: @escaping () -> Void) {
        layoutConstraint.constant = 70
         
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 2,
                       options: .curveLinear,
                       animations: { [weak self] in
                
                        self?.container.layoutIfNeeded()
                        
                       }) { [weak self] (_) in
            
            self?.layoutConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self?.container.layoutIfNeeded()
                
                completion()
            })
        }
    }
}
