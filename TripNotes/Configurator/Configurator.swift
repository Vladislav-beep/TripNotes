//
//  AppCoordinator.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 05.02.2022.
//

import UIKit

class Configurator {
    
    // MARK: - Private properties
    
    private let authService = AuthService()
    private let fireBaseService = FireBaseService()
    private let fileStorageService = FileStorageService()
    private let dateFormatterService = DateFormatterService()
    private let networkManager = NetworkWeatherManager()
    private let locationService = LocationService()
    private let slideInTransitioningDelegate = SlideInPresentationManager()
    private let userDefaultsService = UserDefaultsService()
    
    // MARK: - Methods
    
    func cofigureAuth() -> AuthViewController {
        let viewM = AuthViewModel(authService: authService)
        let auth = AuthViewController(viewModel: viewM)
        auth.modalPresentationStyle = .fullScreen
        auth.configurator = self
        return auth
    }
    
    func configureNewAcc() -> NewAccountViewController {
        let newVM = NewAccountViewModel(authService: authService)
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
        let tripVM = TripsViewModel(fireBaseService: fireBaseService,
                                    userId: userId,
                                    fileStorageService: fileStorageService,
                                    dateFormatterService: dateFormatterService,
                                    authService: authService,
                                    userDefaultsService: userDefaultsService)
        let tripVC = TripsViewController(viewModel: tripVM)
        tripVC.configurator = self
        tripVC.modalPresentationStyle = .fullScreen
        return tripVC
    }
    
    func configureFavoutitesVC(withUser userId: String) -> FavouritesViewController {
        let favVM = FavouritesViewModel(fireBaseService: fireBaseService,
                                        dateFormatterService: dateFormatterService,
                                        userId: userId)
        let favVC = FavouritesViewController(viewModel: favVM)
        favVC.configurator = self
        favVC.modalPresentationStyle = .fullScreen
        return favVC
    }
    
    func configureNotesVC(with notesViewModel: NotesViewModelProtocol) -> NotesViewController {
        let notesVM = notesViewModel
        let notesVC = NotesViewController(notesViewModel: notesVM)
        notesVC.configurator = self
        notesVC.modalPresentationStyle = .fullScreen
        return notesVC
    }
    
    func configureDetailVC(with model: NoteCellViewModelProtocol) -> DetailNoteViewController {
        let detailVC = DetailNoteViewController(viewModel: model)
        detailVC.configurator = self
        slideInTransitioningDelegate.direction = .bottom
        detailVC.transitioningDelegate = slideInTransitioningDelegate
        detailVC.modalPresentationStyle = .custom
        return detailVC
    }
    
    func configureNewTrip(with tripId: String, userId: String, isEdited: Bool) -> NewTripViewController {
        let newTripVM = NewTripViewModel(tripId: tripId,
                                         userId: userId,
                                         fireBaseService: fireBaseService,
                                         fileStorageService: fileStorageService)
        let newtripVC = NewTripViewController(viewModel: newTripVM, isEdited: isEdited)
        newtripVC.modalPresentationStyle = .fullScreen
        return newtripVC
    }
    
    func configureNewNote(with newNoteViewModel: NewNoteViewModelProtocol?, isEdited: Bool) -> NewNoteViewController? {
        if let newNoteVM = newNoteViewModel {
            let newNoteVC = NewNoteViewController(viewModel: newNoteVM, isEdited: isEdited)
            newNoteVC.configurator = self
            newNoteVC.modalPresentationStyle = .fullScreen
            return newNoteVC
        }
        return nil
    }
    
    func configureNewNoteEdited(withUser userId: String, tripId: String, noteId: String) -> NewNoteViewController? {
        let newNoteVM = NewNoteViewModel(userId: userId,
                                         tripId: tripId,
                                         noteId: noteId,
                                         fireBaseService: fireBaseService,
                                         userDefaultsService: userDefaultsService)
        let newNoteVC = NewNoteViewController(viewModel: newNoteVM, isEdited: true)
        newNoteVC.configurator = self
        newNoteVC.modalPresentationStyle = .fullScreen
        return newNoteVC
    }
    
    func configureWeatherVC() -> WeatherViewController {
        let weatherVM = WeatherViewModel(networkManager: networkManager,
                                         locationService: locationService)
        let weatherVC = WeatherViewController(viewModel: weatherVM)
        slideInTransitioningDelegate.direction = .bottom
        weatherVC.transitioningDelegate = slideInTransitioningDelegate
        weatherVC.modalPresentationStyle = .custom
        return weatherVC
    }
    
    func configureMapVC() -> MapViewController {
        let mapVM = MapViewModel(locationService: locationService)
        let mapVC = MapViewController(viewModel: mapVM)
        mapVC.modalPresentationStyle = .fullScreen
        return mapVC
    }
}
