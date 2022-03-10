//
//  Constants.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

struct Constants {
    
    enum ApiKeys: String {
        case weatherKey = "358389cc2e7b7f987ac85f1075b911c6"
    }
    
    enum URLs: String {
        case weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    }
    
    enum ImageNames: String {
        case tripPlaceHolderImage = "tripPlaceHolder"
        case tripDeleteRowImage = "trash"
        case tripEditRowImage = "square.and.pencil"
    }
    
    enum SectionTripNames: String {
        case planned = "Planned"
        case past = "Past trip"
    }
    
    enum CellIdentifiers: String {
        case tripTableViewCellId = "tripTableViewCell"
        case noteCollectionViewCellId = "noteCollectionViewCell"
    }
    
    enum UserDefaults: String {
        case loggedIn = "loggedIn"
    }
}
