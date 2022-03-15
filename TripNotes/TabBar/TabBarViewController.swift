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
    
    var viewModel: TabBarViewModelProtocol
    var configurator: Configurator?
    
    // MARK: Private properties
    
   private var userId: String?
    
    // MARK: Overriden properties
    
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
    
    init(viewModel: TabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelBindings()
        viewModel.fetchUserId()
    }
    
    // MARK: Private methods
    
    private func setupUI(with id: String) {
        tabBar.unselectedItemTintColor = .tripBlue
        tabBar.tintColor = .tripRed
        
        let tripVC = configurator?.configureTripVC(with: id) ?? UIViewController()
        let favVC = configurator?.configureFavoutitesVC() ?? UIViewController()
        
        let firstViewController = UINavigationController(rootViewController: tripVC)
        let secondViewController = UINavigationController(rootViewController: favVC)
        
        firstViewController.tabBarItem.title = "Trips"
        firstViewController.tabBarItem.image = UIImage(systemName: "arrow.triangle.swap")
        
        secondViewController.tabBarItem.title = "Favourites"
        secondViewController.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        viewControllers = [firstViewController, secondViewController]
    }
    
    private func setupViewModelBindings() {
        viewModel.completion = { [weak self]  id in
            self?.userId = id
            self?.setupUI(with: id)
        }
    }
}


