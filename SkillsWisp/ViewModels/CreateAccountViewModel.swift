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
            
            if let imageData = imageData {
                
                try await userDataService.uploadProfileImageToFirebase(imageData: imageData) { imageUrl in
                    guard let imageUrl = imageUrl else {
                        return
                    }
                    
                    self.userDataService.createUserInDB(userId: user.user_id ?? "", email: email, full_name: fullName, phone_no: phoneNo, photoUrl: imageUrl, completion: { isSuccess in
                        
                        self.isSuccessfull = isSuccess
                        self.saveCache(user_id: user.user_id ?? "", full_name: fullName ,
                                       email: user.email ?? "", phone_no: phoneNo,
                                       picture_url: imageUrl)
                    })
                }
                
                
            }
            else {
                userDataService.createUserInDB(userId: user.user_id ?? "", email: user.email, full_name: fullName, phone_no: phoneNo, photoUrl: "", completion: { isSuccess in
                    self.isSuccessfull = isSuccess
                    self.saveCache(user_id: user.user_id ?? "", full_name: fullName,
                                   email: user.email ?? "", phone_no: phoneNo, picture_url: "")
                })
            }
            
            addUser(userId: user.user_id ?? "", fullName: user.full_name ?? "", email: user.email ?? "", phoneNo: phoneNo, picUrl: picUrl)
            
        }
        catch{
            print("Error createUser: \(error)")
        }
        await MainActor.run {
            isLoading = false
        }
        
    }
    
    func saveCache(user_id: String, full_name: String, email: String, phone_no: String, picture_url: String) {
        UserDefaults.standard.set(user_id, forKey: "user_id")
        UserDefaults.standard.set(full_name, forKey: "full_name")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(phone_no, forKey: "phone_no")
        UserDefaults.standard.set(picture_url, forKey: "picture_url")
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
