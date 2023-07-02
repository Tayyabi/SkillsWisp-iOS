//
//  MyProfileViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 01/07/2023.
//

import Foundation
import CoreData
import SwiftUI

class MyProfileViewModel: ObservableObject {
    
    @Published var savedEntities: [UsersEntity] = []
    @Published var userDetails: UsersEntity?
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    init() {
        self.fetchUser()
    }
    
    
    func fetchUser() {
        
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            return
        }
//        if let email = UserDefaults.standard.string(forKey: "email") {
//            print("User email: \(email)")
//        } else {
//            print("User email not found")
//            return
//        }
        
        let fetchRequest: NSFetchRequest<UsersEntity> = UsersEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        
        do {
            savedEntities = try viewContext.fetch(fetchRequest)
            if (savedEntities.count > 0) {
                userDetails = savedEntities.first
            }
            
        } catch {
            print("Error fetching objects: \(error)")
            
        }
        
        
    }
    
    func saveData() {
        do {
            try viewContext.save()
            print("Data saved")
        }
        catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
}
