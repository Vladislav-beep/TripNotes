//
//  TabBarViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override var selectedIndex: Int { // Mark 1
        didSet {
            guard let selectedViewController = viewControllers?[selectedIndex] else { return }
            selectedViewController.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
        }
    }
    
    override var selectedViewController: UIViewController? { // Mark 2
        didSet {
            guard let viewControllers = viewControllers else { return }
            
            for viewController in viewControllers {
                if viewController == selectedViewController {
                    viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
                } else {
                    viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12)], for: .normal)
                }
            }
        }
    }
    
    // MARK: Life Time
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //     UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)], for: .normal)
        //    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .heavy)], for: .selected)
         tabBar.unselectedItemTintColor = .tripBlue
        tabBar.tintColor = .tripRed
        // tabBar.selectedImageTintColor = .tripRed
        
        let firstViewController = UINavigationController(rootViewController: TripsViewController()) 
        let secondViewController = UINavigationController(rootViewController: FavouritesViewController(notesViewModel: FavouritesViewModel()))
        
        firstViewController.tabBarItem.title = "Trips"
        firstViewController.tabBarItem.image = UIImage(named: "tabBarTrip")
        // firstViewController.tabBarItem.badgeColor = .tripRed
        secondViewController.tabBarItem.title = "Favourites"
        secondViewController.tabBarItem.image = UIImage(systemName: "heart.fill")
        viewControllers = [firstViewController, secondViewController]
        
        
    }
    
}
