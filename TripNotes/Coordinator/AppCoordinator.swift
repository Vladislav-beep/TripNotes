//
//  AppCoordinator.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 05.02.2022.
//

import UIKit

protocol Coordinator {
//    var navigationController: UINavigationController { get set }
//    func start()
}

class AppCoordinator: Coordinator {
    
//    var navigationController: UINavigationController
//    let userDefaults = UserDefaltsService()
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        if userDefaults.getLoggedStatus() {
//            showTabBar()
//        } else {
//            showLogin()
//        }
//    }
//
//    func showLogin() {
//        let authVM = AuthViewModel()
//        let auth = AuthViewController(viewModel: authVM)
//        auth.coordinator = self
//        navigationController.pushViewController(auth, animated: true)
//    }
//
//    func showAccount() {
//        let newA = NewAccountViewController(viewModel: NewAccountViewModel())
//        newA.coordinator = self
//        navigationController.pushViewController(newA, animated: true)
//    }
//
//    func showTabBar() {
//        let tabBar = TabBarViewController()
//        tabBar.coordinator = self
//        navigationController.pushViewController(tabBar, animated: true)
//    }
//
//    func showNotes() {
//        let notesVM = NotesViewModel(trip: nil)
//        let notesVC = NotesViewController(notesViewModel: notesVM)
//        notesVC.coordinator = self
//        navigationController.pushViewController(notesVC, animated: true)
//    }
//
//
//    func showFavourites() {
//        let favVM = FavouritesViewModel()
//        let favVc = FavouritesViewController(notesViewModel: favVM)
//        favVc.coordinator = self
//        navigationController.pushViewController(favVc, animated: true)
//    }
//
//    func showNewTrip(tripId: String, isEdited: Bool) {
//        let newTripViewModel = NewTripViewModel(tripId: tripId)
//        let newTripVC = NewTripViewController(viewModel: newTripViewModel, isEdited: isEdited)
//        newTripVC.coordinator = self
//        navigationController.pushViewController(newTripVC, animated: true)
//    }
    
}


class Configurator {
    
    let authService = AuthService()
    
    func cofigureAuth() -> AuthViewController {
        let viewM = AuthViewModel(authService: authService)
        let auth = AuthViewController(viewModel: viewM)
        auth.modalPresentationStyle = .fullScreen
        auth.configurator = self
        return auth
    }
    
    func configureNewAcc() -> NewAccountViewController {
        let newVM = NewAccountViewModel()
        let newVC = NewAccountViewController(viewModel: newVM)
        newVC.configurator = self
        newVC.modalPresentationStyle = .fullScreen
        return newVC
    }
    
    func configureTabbar() -> TabBarViewController {
        let tabbarVM = TabBarViewModel(authService: authService)
        let tabbar = TabBarViewController(viewModel: tabbarVM)
        tabbar.configurator = self
        tabbar.modalPresentationStyle = .fullScreen
        return tabbar
    }
    
    func configureTripVC(with userId: String) -> TripsViewController {
        let tripVM = TripsViewModel(userId: userId)
        let tripVC = TripsViewController(viewModel: tripVM)
        tripVC.configurator = self
        tripVC.modalPresentationStyle = .fullScreen
        return tripVC
    }
    
    func configureFavoutitesVC() -> FavouritesViewController {
        let favVM = FavouritesViewModel()
        let favVC = FavouritesViewController(notesViewModel: favVM)
        favVC.configurator = self
        favVC.modalPresentationStyle = .fullScreen
        return favVC
    }
}
