//
//  Animator.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 12.02.2022.
//

import UIKit

class Animator {
    
    // MARK: Private properties
    
   private let container: UIView
    
    // MARK: Life Time
    
    init(container: UIView) {
        self.container = container
    }
    
    // MARK: Methods
    
    func animate(layoutConstraint: NSLayoutConstraint, completion: @escaping () -> Void) {
        layoutConstraint.constant = 70
         
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 2,
                       options: .curveLinear,
                       animations: { [weak self] in
                
                        self?.container.layoutIfNeeded()
                        
                       }) { [weak self] (_) in
            
            layoutConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self?.container.layoutIfNeeded()
                
                completion()
            })
        }
    }
    
    func animateWarningLabel(warningLabel: UILabel, withText text: String) {
        UIView.transition(with: warningLabel,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: {
                            warningLabel.text = text
                          }, completion: { _ in
                            
                            UIView.transition(with: warningLabel,
                                              duration: 3.5,
                                              options: .transitionCrossDissolve,
                                              animations: {
                                                warningLabel.text = ""
                                              }, completion: nil)
                          })
    }
}
