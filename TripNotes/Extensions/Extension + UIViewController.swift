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
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func setImage(for category: String) -> UIImage {
        switch category {
        case Category.hotels.rawValue:
            return UIImage(systemName: "building.fill") ?? UIImage()
        case Category.transport.rawValue:
            return UIImage(systemName: "tram.tunnel.fill") ?? UIImage()
        case Category.food.rawValue:
            return UIImage(systemName: "hourglass.tophalf.fill") ?? UIImage()
        case Category.activity.rawValue:
            return UIImage(systemName: "camera.on.rectangle.fill") ?? UIImage()
        case Category.purchases.rawValue:
            return UIImage(systemName: "creditcard.fill") ?? UIImage()
        case Category.other.rawValue:
            return UIImage(systemName: "square.3.stack.3d.bottom.fill") ?? UIImage()
        default:
            return UIImage(systemName: "square") ?? UIImage()
        }
    }
}
