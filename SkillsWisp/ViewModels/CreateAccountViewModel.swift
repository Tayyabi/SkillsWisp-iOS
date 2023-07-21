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
    

    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    
    private let persistenceController = PersistenceController.shared
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    // Local - Data method
    func addUser(full_name: String, email: String, phone_no: String, pic_url: String) {
     
        let newUser = UsersEntity(context: viewContext)
        newUser.user_id = UUID()
        newUser.full_name = full_name
        newUser.email = email
        newUser.phone_no = phone_no
        newUser.pic_url = pic_url
        saveData()
    }
    // Local - Data method
    func saveData() {
        do {
            try viewContext.save()
            print("Data saved")
        }
        catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
    //Firebase method
    func createUser(full_name: String, email: String, password: String, phone_no: String, pic_url: String) async throws {
        
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            
            try await createNewUser(user: authDataResult.user, phone_no: phone_no, full_name: full_name)
            //return AuthDataResultModel(user: authDataResult.user)
        }
        catch{
            print("Error: \(error)")
            isLoading = false
        }
        
    }
    
    func createNewUser(user: User, phone_no: String, full_name: String) async throws{
        
        var userData: [String: Any] = [
            "user_id": user.uid,
            "date_created": Timestamp(),
            "phone_no": phone_no,
            "full_name": full_name
        ]
        
        if let email = user.email {
            userData["email"] = email
        }
        if let photoUrl = user.photoURL {
            userData["photo_url"] = photoUrl
        }
        
        
        try await userDocument(userId: user.uid).setData(userData, merge: false)
        
        isLoading = false
        print("Account Created")
        
    }
    
}
