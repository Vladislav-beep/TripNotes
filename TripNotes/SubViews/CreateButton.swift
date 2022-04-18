//
//  CreateButton.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 10.03.2022.
//

import UIKit

class CreateButton: UIButton {
    
    // MARK: Life time
    
    init() {
        super.init(frame: .zero)
        inititalize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func inititalize() {
        setTitle(I.createButtonTitle, for: .normal)
        setTitleColor(.tripBlue, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
