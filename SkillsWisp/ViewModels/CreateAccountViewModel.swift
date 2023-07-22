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
    
    let userDataService = UserDataService()
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    
    
    func createUser(fullName: String, email: String, password: String, phoneNo: String, picUrl: String) async throws {
        
        do {
            
            let user = try await userDataService.createUser(email: email, password: password)
            
            try await userDataService.createUserInDB(userId: user.user_id ?? "", email: user.email, full_name: fullName, phone_no: phoneNo, photoUrl: picUrl)
            
            addUser(userId: user.user_id ?? "", fullName: user.full_name ?? "", email: user.email ?? "", phoneNo: phoneNo, picUrl: picUrl)
            
        }
        catch{
            print("Error createUser: \(error)")
        }
        await MainActor.run {
            isLoading = false
        }
        
    }
    
    // Local - Core Data method
    func addUser(userId: String, fullName: String, email: String, phoneNo: String, picUrl: String) {
     
        var uuid = UUID(uuidString: userId)
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
