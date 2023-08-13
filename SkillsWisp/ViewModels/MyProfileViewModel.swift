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
    @Published var userModel: UserModel?
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    init() {
        self.fetchUser()
    }
    
    func getCache() {
        
        guard let user_id = UserDefaults.standard.string(forKey: "user_id"),
              let full_name = UserDefaults.standard.string(forKey: "full_name"),
              let email = UserDefaults.standard.string(forKey: "email"),
              let phone_no = UserDefaults.standard.string(forKey: "phone_no"),
              let picture_url = UserDefaults.standard.string(forKey: "picture_url")
        else {
            return
        }
        
        userModel = UserModel(userId: user_id, fullName: full_name, email: email, phoneNo: phone_no, picUrl: picture_url)
        
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
                //userModel = savedEntities.first
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
