//
//  Extension + UITextField.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 30.12.2021.
//

import UIKit

extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 358))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.tintColor = .tripRed
        datePicker.sizeToFit()
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                     style: .plain,
                                     target: nil,
                                     action: #selector(tapCancel))
        let doneButton = UIBarButtonItem(title: "Continue",
                                         style: .plain,
                                         target: target,
                                         action: selector)
        toolBar.setItems([cancelButton, flexible, doneButton], animated: true)
        inputAccessoryView = toolBar
        
        let dateView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 358))
        dateView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: dateView.topAnchor, constant: 8).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 16).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: dateView.centerXAnchor).isActive = true
        
        inputView = dateView
    }
    
    @objc private func tapCancel() {
        resignFirstResponder()
    }
}
