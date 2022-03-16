//
//  KeyboardHelper.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 16.03.2022.
//

import UIKit

class KeyboardHelper {
    
    // MARK: Private properties
    
    private let scrollView: UIScrollView
    private let offSet: CGFloat
    
    // MARK: Life Time
    
    init(scrollView: UIScrollView, offSet: CGFloat) {
        self.scrollView = scrollView
        self.offSet = offSet
    }
    
    // MARK: Methods
    
    func registerKeyBoardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: ((keyboardFrame?.height ?? 0) / 2) - offSet)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
}
