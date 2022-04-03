//
//  TabBarViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 15.03.2022.
//

import Foundation

protocol TabBarViewModelProtocol {
    var completion: ((String) -> Void)? { get set }
    var errorCompletion: (() -> Void)? { get set }
    func fetchUserId() 
}

class TabBarViewModel: TabBarViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let auth: AuthService
    
    // MARK: - Properties
    
    var completion: ((String) -> Void)?
    var errorCompletion: (() -> Void)?
    
    // MARK: - Life Time
    
    init(authService: AuthService) {
        self.auth = authService
    }
    
    // MARK:  - Methods
    
    func fetchUserId() {
        auth.getUserId(completion: { [weak self] (result: Result<String, AuthError>) in
            switch result {
            case .success(let id):
                self?.completion?(id)
            case .failure(let error):
                self?.errorCompletion?()
                print(error.localizedDescription)
            }
        })
    }
}
