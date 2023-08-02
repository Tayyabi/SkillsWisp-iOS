//
//  AuthenticationManager.swift
//  SkillsWisp
//
//  Created by M Tayyab on 17/07/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserDataService {
    
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    
    
    
    func createUserInDB(userId: String, email: String?, full_name: String, phone_no: String, photoUrl: String?) async throws {
        
        var userData: [String: Any] = [
            "user_id": userId,
            "date_created": Timestamp(),
            "phone_no": phone_no,
            "full_name": full_name
        ]
        
        if let email = email {
            userData["email"] = email
        }
        if let photoUrl = photoUrl {
            userData["photo_url"] = photoUrl
        }
        
        
        try await userDocument(userId: userId).setData(userData, merge: false)
        
        print("Account Created")
        
    }
    
    
    func fetchUserFromDB(userId: String, completion: @escaping (UserModel?) -> Void)  async throws {
        
        userDocument(userId: userId).getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                completion(nil)
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    
                    
                    let user = UserModel(user_id: userId,
                                        full_name: data["full_name"] as? String ?? "UNKNOWN",
                                        email:data["email"] as? String ?? "UNKNOWN",
                                        phone_no: data["phone_no"] as? String ?? "UNKNOWN")
                    completion(user)
                    
                }
            }
            else {
                completion(nil)
            }
        }
    }
    
    
    
    func getAuthenticatedUser() throws -> UserModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return UserModel(user_id: user.uid , email: user.email ?? "")
    }
    
    func createUser(email: String, password: String) async throws -> UserModel {
        
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return UserModel(user_id: authDataResult.user.uid , email: authDataResult.user.email ?? "")
        
    }
    
    func signIn(email: String, password: String) async throws -> UserModel {
        
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return UserModel(user_id: authDataResult.user.uid , email: authDataResult.user.email ?? "")
        
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: password)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    
}