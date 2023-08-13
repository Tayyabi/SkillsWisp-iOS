//
//  LoginViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 01/07/2023.
//

import Foundation
import CoreData
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class LoginViewModel: ObservableObject {
    
    @Published var savedEntities: [UsersEntity] = []
    @Published var shouldNavigate = false
    @Published var isLoading = false
    
    let userDataService = UserDataService()
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    
    func signIn(email: String, password: String) async throws {
        
        do {
            let user = try await userDataService.signIn(email: email, password: password)
            
            try await userDataService.fetchUserFromDB(userId: user.user_id ?? "") { user in
                
                if let user = user {
                    self.saveCache(user_id: user.user_id ?? "", full_name: user.full_name ?? "",
                                   email: user.email ?? "", phone_no: user.phone_no ?? "", picture_url: user.pic_url ?? "")
                }
                else {
                    print("Error: fetchUserFromDB")
                }
            }
            
            await MainActor.run {
                self.isLoading = false
                self.shouldNavigate = true
            }
        }
        catch {
            await MainActor.run {
                self.isLoading = false
            }
            print("Error signIn: \(error)")
        }
        
    }
    
    // Local - Core Data method
    func authenticateUser(email: String) {
        
        let fetchRequest: NSFetchRequest<UsersEntity> = UsersEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            
            let matchingUsers = try viewContext.fetch(fetchRequest)
            
            if matchingUsers.isEmpty {
                print("User does not exist")
                
            } else {
                print("User exists")
                self.shouldNavigate = true
                if let userEntity = matchingUsers.first {
                    
                    print("User ID: \(userEntity.user_id?.uuidString ?? "")")
                    print("User Name: \(userEntity.full_name ?? "")")
                    print("User Email: \(userEntity.email ?? "")")
                    
                    saveCache(user_id: userEntity.user_id?.uuidString ?? "", full_name: userEntity.full_name ?? "",
                              email: userEntity.email ?? "", phone_no: userEntity.phone_no ?? "", picture_url: "")
                    
                }
                
            }
            
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            
        }
        
    }
    
    func saveCache(user_id: String, full_name: String, email: String, phone_no: String, picture_url: String) {
        UserDefaults.standard.set(user_id, forKey: "user_id")
        UserDefaults.standard.set(full_name, forKey: "full_name")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(phone_no, forKey: "phone_no")
        UserDefaults.standard.set(picture_url, forKey: "picture_url")
    }
    
    
    /*func fetchUsers(){
        let fetchRequest: NSFetchRequest<UsersEntity> = UsersEntity.fetchRequest()

        do {
            let fetchedUsers = try self.container.viewContext.fetch(fetchRequest)

            for user in fetchedUsers {
                let email = user.email // Access the email attribute
                let name = user.full_name // Access other attributes

                // Print or process the retrieved data as needed
                print("User: \(name), Email: \(email)")
            }
        } catch {
            // Handle the error appropriately
            print("Error fetching users: \(error.localizedDescription)")
        }
    }*/
    
    
}
