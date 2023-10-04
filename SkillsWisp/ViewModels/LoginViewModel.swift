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
    @Published var isAuthorizationFailed = false
    
    let userDataService = UserDataService()
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    
    func signIn(email: String, password: String) async throws {
        
        do {
            let user = try await userDataService.signIn(email: email, password: password)
            
            let user1 = try await userDataService.fetchUserFromDB(userId: user.userId )
            
            if let usr = user1 {
                self.saveCache(user: usr)
            }
            
            
            await MainActor.run {
                self.isLoading = false
                self.shouldNavigate = true
            }
        }
        catch {
            
            let  errorCode = AuthErrorCode(_nsError: error as NSError)
            
            switch(errorCode) {
            case AuthErrorCode.wrongPassword:
                print("Error signIn: wrong password")
            case AuthErrorCode.invalidEmail:
                print("Error signIn: invalid email")
            default:
                print("An error occurred: \(errorCode)")
            }
            
            await MainActor.run {
                self.isLoading = false
                self.isAuthorizationFailed = true
            }
            
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
                    
                    //saveCache(user_id: userEntity.user_id?.uuidString ?? "", full_name: userEntity.full_name ?? "",
                      //        email: userEntity.email ?? "", phone_no: userEntity.phone_no ?? "", picture_url: "")
                    
                }
                
            }
            
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
            
        }
        
    }
    
    func saveCache(user: UserModel) {
        
        UserDefaults.standard.set(user.userId, forKey: "user_id")
        UserDefaults.standard.set(user.fullName, forKey: "full_name")
        UserDefaults.standard.set(user.email, forKey: "email")
        UserDefaults.standard.set(user.phoneNo, forKey: "phone_no")
        UserDefaults.standard.set(user.picUrl, forKey: "picture_url")
        UserDefaults.standard.set(true, forKey: "is_login")
        
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
