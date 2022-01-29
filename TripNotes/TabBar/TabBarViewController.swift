//
//  TabBarViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: Life Time

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = UINavigationController(rootViewController: TripsViewController()) 
        let secondViewController = UINavigationController(rootViewController: FavouritesViewController())
        
        firstViewController.tabBarItem.title = "Trips"
        firstViewController.tabBarItem.image = UIImage(systemName: "pencil")
        secondViewController.tabBarItem.title = "Favourites"
        secondViewController.tabBarItem.image = UIImage(systemName: "circle.fill")
        viewControllers = [firstViewController, secondViewController]
    }
    
}
