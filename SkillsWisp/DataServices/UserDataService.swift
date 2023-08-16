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
import Firebase
import FirebaseStorage

final class UserDataService {
    
    
    private let userCollection = Firestore.firestore().collection("users")
    let storage = Storage.storage()
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    
    func createUserInDB(user: UserModel, completion: @escaping (Bool) -> ()) {
        
        do {
            try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: Coders.encoder){ error in
                if let error = error {
                    print("Error createUserInDB: \(error)")
                    completion(false)
                } else {
                    print("Account Created")
                    return completion(true)
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    func createUserInDB(userId: String, email: String?, full_name: String, phone_no: String, photoUrl: String?, completion: @escaping (Bool) -> ()) {
        
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
  
        userDocument(userId: userId).setData(userData, merge: false){ error in
            if let error = error {
                print("Error createUserInDB: \(error)")
                completion(false)
            } else {
                print("Account Created")
                return completion(true)
            }
        }
        
        
        
    }
    
    func updateUserInDB(full_name: String, phone_no: String, photoUrl: String, completion: @escaping (Bool) -> ()) {
        
        guard let user = Auth.auth().currentUser else { return }
        var userData: [String: Any] = [
            "phone_no": phone_no,
            "full_name": full_name,
            
        ]
        if !photoUrl.isEmpty {
            userData["photo_url"] = photoUrl
        }
        
        userDocument(userId: user.uid).updateData(userData){ error in
            if let error = error {
                print("Error updating document: \(error)")
                completion(false)
            } else {
                print("Document successfully updated!")
                completion(true)
            }
        }
        
    }
    
    func uploadProfileImageToFirebase(imageData: Data,completion: @escaping (String?) -> ()) async throws {
        
        let imageName = "\(UUID().uuidString).jpg"
        let storageRef = storage.reference().child("profile_images/\(imageName)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                completion(nil)
                print("Error uploading image: \(error.localizedDescription)")
            } else {
                print("Image uploaded successfully!")
                // Do something with the image URL if needed (metadata?.downloadURL())
                storageRef.downloadURL { url, error in
                    if let error = error {
                        completion(nil)
                        print("Error getting download URL: \(error.localizedDescription)")
                    } else if let downloadURL = url {
                        print("Download URL: \(downloadURL.absoluteString)")
                        completion(downloadURL.absoluteString)
                    }
                }
            }
        }
    }
    
    func fetchUserFromDB(userId: String) async throws -> UserModel? {
        return try await userDocument(userId: userId).getDocument(as: UserModel.self)
    }
    
//    func fetchUserFrom DB(userId: String, completion: @escaping (UserModel?) -> Void)  async throws {
//
//        userDocument(userId: userId).getDocument { (document, error) in
//            guard error == nil else {
//                print("error", error ?? "")
//                completion(nil)
//                return
//            }
//
//            guard let document = document else {
//                print("Document does not exist")
//                completion(nil)
//                return
//            }
//
//            if let data = document.data() {
//                let user = try self.decoder.decode(UserModel.self, from: data)
//                print("User: \(user)")
//            }
//
//            else {
//                completion(nil)
//            }
//        }
//    }
    
    
    
    func getAuthenticatedUser() throws -> UserModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return UserModel(userId: user.uid , email: user.email ?? "")
    }
    
    func createUser(email: String, password: String) async throws -> UserModel {
        
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return UserModel(userId: authDataResult.user.uid , email: authDataResult.user.email ?? "")
        
    }
    
    func signIn(email: String, password: String) async throws -> UserModel {
        
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return UserModel(userId: authDataResult.user.uid , email: authDataResult.user.email ?? "")
        
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
