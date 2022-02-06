//
//  KeyboardService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 06.02.2022.
//

import UIKit

class KeyboardService {
    
//    var scrollView: UIScrollView?
//    
//    init(scrollView: UIScrollView?) {
//        self.scrollView = scrollView
//    }
    
    func registerKeyBoardNotification(scrollView: UIScrollView) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification, for scrollView: UIScrollView) {
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: (keyboardFrame?.height ?? 0) / 2)
    }
    
    @objc private func keyboardWillHide(notification: Notification, for scrollView: UIScrollView) {
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
