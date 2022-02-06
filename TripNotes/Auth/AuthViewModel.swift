//
//  AuthViewModel.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 24.01.2022.
//

import Foundation

protocol AuthViewModelProtocol {
    func registerKeyboardNotification()
    func removeKeyboardNotification()
}


class AuthViewModel: AuthViewModelProtocol {
    
    var keyboardService: KeyboardService
    
    init(keyboardService: KeyboardService) {
        self.keyboardService = keyboardService
    }
    
    func registerKeyboardNotification() {
  //      keyboardService.registerKeyBoardNotification(scrollView: <#UIScrollView#>)
    }
    
    func removeKeyboardNotification() {
        keyboardService.removeKeyboardNotification()
    }
    
}
