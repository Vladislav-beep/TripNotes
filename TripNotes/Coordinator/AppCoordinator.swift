//
//  AppCoordinator.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 05.02.2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showTabBar()
    }
    
    func showLogin() {
        let authVM = AuthViewModel()
        let auth = AuthViewController(viewModel: authVM)
        auth.coordinator = self
        navigationController.pushViewController(auth, animated: true)
    }
    
    func showTabBar() {
        let tabBar = TabBarViewController()
        tabBar.coordinator = self
        navigationController.pushViewController(tabBar, animated: true)
    }
    
    func showTrips() {
        let tripsVC = TripsViewController()
        tripsVC.coordinator = self
        navigationController.pushViewController(tripsVC, animated: true)
    }
    
    func showNotes() {
        let notesVM = NotesViewModel(trip: nil)
        let notesVC = NotesViewController(notesViewModel: notesVM)
        notesVC.coordinator = self
        navigationController.pushViewController(notesVC, animated: true)
    }
    
    
    func showFavourites() {
        let favVM = FavouritesViewModel()
        let favVc = FavouritesViewController(notesViewModel: favVM)
        favVc.coordinator = self
        navigationController.pushViewController(favVc, animated: true)
    }
    
}
