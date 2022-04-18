//
//  Extension + UIViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 12.03.2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: I.okButton, style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showSignOutAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: I.yes, style: .default) { _ in
            completion()
        }
        let cancelAction = UIAlertAction(title: I.no, style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func setImage(for category: String) -> UIImage {
        switch category {
        case Category.hotels.rawValue:
            return UIImage(systemName: C.ImageNames.hotel.rawValue) ?? UIImage()
        case Category.transport.rawValue:
            return UIImage(systemName: C.ImageNames.transport.rawValue) ?? UIImage()
        case Category.food.rawValue:
            return UIImage(systemName: C.ImageNames.food.rawValue) ?? UIImage()
        case Category.activity.rawValue:
            return UIImage(systemName: C.ImageNames.activity.rawValue) ?? UIImage()
        case Category.purchases.rawValue:
            return UIImage(systemName: C.ImageNames.purchases.rawValue) ?? UIImage()
        case Category.other.rawValue:
            return UIImage(systemName: C.ImageNames.other.rawValue) ?? UIImage()
        default:
            return UIImage(systemName: C.ImageNames.defaultCategory.rawValue) ?? UIImage()
        }
    }
}
