//
//  SearchController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.03.2022.
//

import UIKit

class SearchController: UISearchController {
    
    // MARK: Life Time
    
    init() {
        super.init(nibName: nil, bundle: nil)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func initialize() {
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = I.searchBarPlaceholder
        searchBar.scopeButtonTitles = [I.allScope,
                                       I.hotelsScope,
                                       I.transportScope,
                                       I.foodScope,
                                       I.activityScope,
                                       I.purchasesScope,
                                       I.otherScope]
        searchBar.searchTextField.backgroundColor = .tripWhite
        definesPresentationContext = true
    }
}
