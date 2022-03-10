//
//  TabBarViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit
import Firebase

class TabBarViewController: UITabBarController {
    
    // MARK: Dependencies
    
    var coordinator: AppCoordinator?
    
    var user: User!
    
    var userId: String?

    // MARK: Overriden
    
    override var selectedIndex: Int {
        didSet {
            guard let selectedViewController = viewControllers?[selectedIndex] else { return }
            selectedViewController.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
        }
    }
    
    override var selectedViewController: UIViewController? {
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
        
        let firstViewController = UINavigationController(rootViewController: TripsViewController(viewModel: TripsViewModel(userId: "NUXiX5zSMiwYxmtCBpzO")))
        let secondViewController = UINavigationController(rootViewController: FavouritesViewController(notesViewModel: FavouritesViewModel()))

        firstViewController.tabBarItem.title = "Trips"
        firstViewController.tabBarItem.image = UIImage(systemName: "arrow.triangle.swap")
        
        secondViewController.tabBarItem.title = "Favourites"
        secondViewController.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        viewControllers = [firstViewController, secondViewController]
        let auth = AuthService()
        
        
        
        auth.completion = { [weak self] id in
            self?.userId = id
            print("\(self?.userId) - from tabbar")
        }
        
        auth.getUserId()
//        auth.getUserId { (result: Result<String, Error>) in
//            switch result {
//            case .success(let id):
//                self.userId = id
//                print("\(self.userId) - from tabbar")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        print("\(userId) - from tabbarAAAAA")
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.view.backgroundColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


