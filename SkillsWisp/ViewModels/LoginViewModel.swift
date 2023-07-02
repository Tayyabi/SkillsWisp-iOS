//
//  LoginViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 01/07/2023.
//

import Foundation
import CoreData

class LoginViewModel: ObservableObject {
    
    @Published var savedEntities: [UsersEntity] = []
    @Published var shouldNavigate = false
    
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    
    func authenticateUser(email: String) {
        
        let fetchRequest: NSFetchRequest<UsersEntity> = UsersEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            
            let matchingUsers = try viewContext.fetch(fetchRequest)
            
            if matchingUsers.isEmpty {
                print("Email does not exist")
                
            } else {
                print("Email exists")
                self.shouldNavigate = true
                if let userEntity = matchingUsers.first {
                    
                    print("User ID: \(userEntity.user_id?.uuidString ?? "")")
                    print("User Name: \(userEntity.full_name ?? "")")
                    print("User Email: \(userEntity.email ?? "")")
                    
                    UserDefaults.standard.set(userEntity.user_id?.uuidString ?? "", forKey: "user_id")
                    UserDefaults.standard.set(userEntity.full_name ?? "", forKey: "full_name")
                    UserDefaults.standard.set(userEntity.email ?? "", forKey: "email")
                    UserDefaults.standard.set(userEntity.phone_no ?? "", forKey: "phone_no")
                    
                }
                
            }
            
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            
        }
        
    }
    
//    func fetchUsers(){
//        let fetchRequest: NSFetchRequest<UsersEntity> = UsersEntity.fetchRequest()
//
//        do {
//            let fetchedUsers = try self.container.viewContext.fetch(fetchRequest)
//
//            for user in fetchedUsers {
//                let email = user.email // Access the email attribute
//                let name = user.full_name // Access other attributes
//
//                // Print or process the retrieved data as needed
//                print("User: \(name), Email: \(email)")
//            }
//        } catch {
//            // Handle the error appropriately
//            print("Error fetching users: \(error.localizedDescription)")
//        }
//    }
    
    
    
    
}
