//
//  MyProfileViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 01/07/2023.
//

import Foundation
import CoreData
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var savedEntities: [UsersEntity] = []
    @Published var userModel: UserModel?
    @Published var isLoading = false
    @Published var imageData: Data?
    @Published var isSuccessfull: Bool = false
    
    
    let userDataService = UserDataService()
    
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    init() {
        self.fetchUser()
    }
    
    func getCache() {
        
        let user_id = UserDefaults.standard.string(forKey: "user_id") ?? ""
        let full_name = UserDefaults.standard.string(forKey: "full_name") ?? ""
        let email = UserDefaults.standard.string(forKey: "email") ?? ""
        let phone_no = UserDefaults.standard.string(forKey: "phone_no") ?? ""
        let picture_url = UserDefaults.standard.string(forKey: "picture_url") ?? ""
        
        
        userModel = UserModel(userId: user_id, fullName: full_name, email: email, phoneNo: phone_no, picUrl: picture_url)
        
    }
    
    func updateUser(fullName: String, phoneNo: String) async {
        
        do {
            
            isLoading = true
            
            if let imageData = imageData {
                
                try await userDataService.uploadProfileImageToFirebase(imageData: imageData) { [weak self] imageUrl in
                    
                    guard let imageUrl = imageUrl else { return }
                    
                    self?.userModel?.fullName = fullName
                    self?.userModel?.phoneNo = phoneNo
                    self?.userModel?.picUrl = imageUrl
                    
                    
                    self?.userDataService.updateUserInDB(full_name: fullName, phone_no: phoneNo, photoUrl: imageUrl,
                                                         completion: { isSuccess in
                        
                        self?.isSuccessfull = isSuccess
                        self?.saveCache()
                    })
                }
                
            }
            else {
                self.userDataService.updateUserInDB(full_name: fullName, phone_no: phoneNo, photoUrl: "",
                                                     completion: { [weak self] isSuccess in
                    
                    self?.isSuccessfull = isSuccess
                    self?.saveCache()
                })
            }
            
        }
        catch{
            print("Error updateUser: \(error)")
            await MainActor.run {
                isLoading = false
            }
        }
        await MainActor.run {
            isLoading = false
        }
        
    }
    
    func saveCache() {
        UserDefaults.standard.set(self.userModel?.fullName, forKey: "full_name")
        UserDefaults.standard.set(self.userModel?.phoneNo, forKey: "phone_no")
        UserDefaults.standard.set(self.userModel?.picUrl, forKey: "picture_url")
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
