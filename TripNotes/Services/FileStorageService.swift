//
//  FileStorageService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.03.2022.
//

import UIKit

protocol FileStorageServiceProtocol {
    func store(image: Data, forKey key: String)
    func retrieveImage(forKey key: String) -> Data?
    func delete(forKey key: String)
}

class FileStorageService: FileStorageServiceProtocol {
    
    private let fileManager = FileManager.default
    
    // MARK: Private methods
    
    private func filePath(forKey key: String) -> URL? {
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    // MARK: Methods
    
    func store(image: Data, forKey key: String) {
        if let filePath = filePath(forKey: key) {
            do  {
                try image.write(to: filePath, options: [])
            } catch let err {
                print("Saving file resulted in error: ", err)
            }
        }
    }
    
    func retrieveImage(forKey key: String) -> Data? {
        if let filePath = self.filePath(forKey: key),
           let fileData = FileManager.default.contents(atPath: filePath.path) {
            return fileData
        }
        return nil
    }
    
    func delete(forKey key: String) {
        if let filePath = filePath(forKey: key) {
        do {
            try fileManager.removeItem(atPath: filePath.path)
        } catch let err {
            print("Coudn't delete image", err)
        }
    }
    }
}
