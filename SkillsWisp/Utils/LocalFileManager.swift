//
//  LocalFileManager.swift
//  SkillsWisp
//
//  Created by M Tayyab on 06/09/2023.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instacne = LocalFileManager()
    
    let folderName = "SkillsWisp"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            
            print("Error getting path")
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            
            do {
                
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true,attributes: nil)
                
                print("Success creating folder")
            }catch let error {
                print("Error creating folder \(error)")
            }
        }
        
    }
    
    func saveImage(data: Data, name: String) {
        
        guard
            let path = getPathForImage(name: name) else {
            print("Error getting data")
            return
        }
        
//        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
//        let directory2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let directory3 = FileManager.default.temporaryDirectory
        
        
    
        do {
            try  data.write(to: path)
            print("Success saved!")
        }catch {
            print(error)
            print("Error saving data")
        }
    }
    
    func getImage(name: String) -> UIImage? {
        
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
        
    }
    
    func deleteImage(name: String) {
        
        guard
            let path = getPathForImage(name: name),
            FileManager.default.fileExists(atPath: path.path) else {
            print("Error getting path")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            print("Success deleted!")
        }catch {
            print(error)
            print("Error deleting data")
        }
        
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name)") else {
            print("Error getting path")
            return nil
        }
        
        print("path: \(path.path)")
        
        return path
    }
    
    func generateUniqueFilename() -> String {
        let timestamp = Date().timeIntervalSince1970
        let random = Int.random(in: 1...10000) // You can adjust the range as needed
        return "\(timestamp)_\(random)"
    }
}
