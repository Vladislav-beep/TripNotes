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
        
        tabBar.unselectedItemTintColor = .tripBlue
        tabBar.selectedImageTintColor = .tripRed

        let firstViewController = UINavigationController(rootViewController: TripsViewController()) 
        let secondViewController = UINavigationController(rootViewController: FavouritesViewController(notesViewModel: FavouritesViewModel()))
        
        firstViewController.tabBarItem.title = "Trips"
        firstViewController.tabBarItem.image = UIImage(named: "1")
        firstViewController.tabBarItem.badgeColor = .tripRed
        secondViewController.tabBarItem.title = "Favourites"
        secondViewController.tabBarItem.image = UIImage(systemName: "heart.fill")
        viewControllers = [firstViewController, secondViewController]
    }
    
}
