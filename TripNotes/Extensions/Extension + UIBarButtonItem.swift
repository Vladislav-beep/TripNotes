//
//  Extension + UIBarButtonItem.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 16.12.2021.
//

import UIKit

extension UIBarButtonItem {

    static func customButton(_ target: Any?, action: Selector, imageName: String, widthAndHeight: Int) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: CGFloat(widthAndHeight)).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: CGFloat(widthAndHeight)).isActive = true

        return menuBarItem
    }
}
