//
//  FileStorageService.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.03.2022.
//

import UIKit

class FileStorageService {
    
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    func store(image: Data, forKey key: String) {
        if let filePath = filePath(forKey: key) {
            do  {
                try image.write(to: filePath, options: .atomic)
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
}
