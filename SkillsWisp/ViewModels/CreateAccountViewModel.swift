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
    
    
    func addUser(user: User){
     
        let newUser = UsersEntity(context: viewContext)
        newUser.user_id = UUID()
        newUser.full_name = user.full_name
        newUser.email = user.email
        newUser.phone_no = user.phone_no
        newUser.pic_url = user.pic_url
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
