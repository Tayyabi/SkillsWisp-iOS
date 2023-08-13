//
//  CreateAccountViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 01/07/2023.
//

import Foundation
import CoreData
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class CreateAccountViewModel: ObservableObject {
    
    @Published var savedEntities: [UsersEntity] = []
    @Published var isLoading = false
    @Published var imageData: Data?
    @Published var isSuccessfull: Bool = false
    
    let userDataService = UserDataService()
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    
    
    func createUser(fullName: String, email: String, password: String, phoneNo: String, picUrl: String) async throws {
        
        do {
            
            isLoading = true
            
            let user = try await userDataService.createUser(email: email, password: password)
            
            var userModel = UserModel(userId: user.userId , fullName: fullName, email: email ,phoneNo: phoneNo, picUrl: "")
            if let imageData = imageData {
                
                try await userDataService.uploadProfileImageToFirebase(imageData: imageData) { [weak self] imageUrl in
                    
                    guard let imageUrl = imageUrl else {
                        return
                    }
                    
                    userModel.picUrl = imageUrl
                    
                    self?.userDataService.createUserInDB(user: userModel, completion: { isSuccess in
                        
                        self?.isSuccessfull = isSuccess
                        self?.saveCache(user: userModel)
                    })
                }
                
            }
            else {
                userDataService.createUserInDB(user: userModel, completion: { [weak self] isSuccess in
                    self?.isSuccessfull = isSuccess
                    self?.saveCache(user: userModel)
                })
            }
            
            addUser(userId: user.userId, fullName: user.fullName ?? "", email: user.email , phoneNo: phoneNo, picUrl: picUrl)
            
        }
        catch{
            print("Error createUser: \(error)")
        }
        await MainActor.run {
            isLoading = false
        }
        
    }
    
    func saveCache(user: UserModel) {
        UserDefaults.standard.set(user.userId, forKey: "user_id")
        UserDefaults.standard.set(user.fullName, forKey: "full_name")
        UserDefaults.standard.set(user.email, forKey: "email")
        UserDefaults.standard.set(user.phoneNo, forKey: "phone_no")
        UserDefaults.standard.set(user.picUrl, forKey: "picture_url")
    }
    
    // Local - Core Data method
    func addUser(userId: String, fullName: String, email: String, phoneNo: String, picUrl: String) {
     
        let uuid = UUID(uuidString: userId)
        let newUser = UsersEntity(context: viewContext)
        newUser.user_id = uuid
        newUser.full_name = fullName
        newUser.email = email
        newUser.phone_no = phoneNo
        newUser.pic_url = picUrl
        saveData()
    }
    // Local - Core Data method
    func saveData() {
        do {
            try viewContext.save()
            print("Data saved")
        }
        catch let error {
            print("Error saveData: \(error)")
        }
        
    }
    
    
}
