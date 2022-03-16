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
    var userId: String? { get }
    func fetchUserId() 
}

class TabBarViewModel: TabBarViewModelProtocol {
    
    // MARK: Dependencies
    
    let auth: AuthService
    
    // MARK: Properties
    
    var completion: ((String) -> Void)?
    var errorCompletion: (() -> Void)?
    var userId: String?
    
    // MARK: Life Time
    
    init(authService: AuthService) {
        self.auth = authService
    }
    
    // MARK: Methods
    
    func fetchUserId() {
        auth.getUserId(completion: { (result: Result<String, AuthError>) in
            switch result {
            case .success(let id):
                self.userId = id
                self.completion?(id)
            case .failure(let error):
                self.errorCompletion?()
                print(error.localizedDescription)
            }
        })
    }
}
