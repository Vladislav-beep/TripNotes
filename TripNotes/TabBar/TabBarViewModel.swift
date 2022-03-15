//
//  TabBarViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 15.03.2022.
//

import Foundation

protocol TabBarViewModelProtocol {
    var completion: ((String) -> Void)? { get set }
    var userId: String? { get }
    func fetchUserId() 
}


class TabBarViewModel: TabBarViewModelProtocol {
    
    let auth: AuthService
    
    var completion: ((String) -> Void)?
    var userId: String?
    
    init(authService: AuthService) {
        self.auth = authService
    }
    
    
    func fetchUserId() {
        auth.getUserId(completion: { (result: Result<String, Error>) in
            switch result {
            case .success(let id):
                self.userId = id
                print("\(id) - id from viewModel")
                print("\(self.userId) - userId from viewModel")
                self.completion?(id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
