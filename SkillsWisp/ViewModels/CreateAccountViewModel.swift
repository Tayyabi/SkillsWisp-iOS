//
//  CreateAccountViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 01/07/2023.
//

import Foundation
import CoreData

class CreateAccountViewModel: ObservableObject {
    
    @Published var savedEntities: [UsersEntity] = []
    

    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    
    func addUser(full_name: String, email: String, phone_no: String, pic_url: String){
     
        let newUser = UsersEntity(context: viewContext)
        newUser.user_id = UUID()
        newUser.full_name = full_name
        newUser.email = email
        newUser.phone_no = phone_no
        newUser.pic_url = pic_url
        saveData()
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
