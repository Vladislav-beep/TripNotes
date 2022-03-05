//
//  Constants.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import Foundation

struct Constants {
    
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
}
