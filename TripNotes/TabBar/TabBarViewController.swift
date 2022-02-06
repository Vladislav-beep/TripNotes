//
//  TabBarViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var coordinator: AppCoordinator?
    
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
        
        tabBar.unselectedItemTintColor = .tripBlue
        tabBar.tintColor = .tripRed
        
      //  let firstViewController = TripsViewController()
       // let secondViewController = FavouritesViewController(notesViewModel: FavouritesViewModel())
        let firstViewController = UINavigationController(rootViewController: TripsViewController())
        let secondViewController = UINavigationController(rootViewController: FavouritesViewController(notesViewModel: FavouritesViewModel()))
        
        firstViewController.tabBarItem.title = "Trips"
        firstViewController.tabBarItem.image = UIImage(named: "tabBarTrip")
        
        secondViewController.tabBarItem.title = "Favourites"
        secondViewController.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        viewControllers = [firstViewController, secondViewController]
    }
    
    
}


