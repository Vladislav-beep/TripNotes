//
//  FileStorageServiceMock.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 19.05.2022.
//

import Foundation

class FileStorageServiceMock: FileStorageServiceProtocol {
    
    // MARK: Public
    
    func store(image: Data, forKey key: String) {
        
    }
    
    func retrieveImage(forKey key: String) -> Data? {
        return Data()
    }
    
    func delete(forKey key: String) {
        
    }
}
