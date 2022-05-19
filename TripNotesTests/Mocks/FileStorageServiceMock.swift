//
//  FileStorageServiceMock.swift
//  TripNotesTests
//
//  Created by Владислав Сизонов on 19.05.2022.
//

import Foundation

class FileStorageServiceMock: FileStorageServiceProtocol {
    
    func store(image: Data, forKey key: String) {
        
    }
    
    func retrieveImage(forKey key: String) -> Data? {
        
    }
    
    func delete(forKey key: String) {
        
    }
    
    
}
