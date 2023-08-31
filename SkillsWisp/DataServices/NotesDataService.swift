//
//  NotesDataService.swift
//  SkillsWisp
//
//  Created by M Tayyab on 03/08/2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

enum UserError: Error {
    case userNotLogin, userNotThere
}

final class NotesDataService {
    
    private let ratingsreviewsCollection = Firestore.firestore().collection("ratings_reviews")
    private let standardsCollection = Firestore.firestore().collection("standards")
    private let userCollection = Firestore.firestore().collection("users")
    
    
    func addLikesInDB(standard_id: String, subject_id: String,note_id: String, like: LikeModel) async throws {
        
        
        guard let user = Auth.auth().currentUser else { return }
        
        let userID: [String: Any] = [
            "user_id": user.uid
        ]
        
        
        
        
        try await ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).setData(userID, merge: false)
        let likeDocRef = ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).collection("user_likes")
        
        
        var ref: DocumentReference? = nil
        ref = try likeDocRef.addDocument(from: like, encoder: Coders.encoder) { error in
            if let error = error {
                print("Error: addLikesInDB: \(error)")
            } else {
                print("addLikesInDB: like added with ID: \(ref!.documentID)")
            }
        }
        
        try await userCollection.document(user.uid).collection("user_likes").document(note_id)
            .setData([
                "standard_id":standard_id,
                "note_id":note_id,
                "subject_id": subject_id], merge: false)
        
    }
    
    
    /*func addLikesInDB(note_id: String, like: Bool) async throws {
        
        
        guard let user = Auth.auth().currentUser else { return }
        
        let name = UserDefaults.standard.string(forKey: "full_name") ?? "UnKnown"
        let likeData: [String: Any] = [
            
            "name": name,
            "like": like,
            "date_created": Timestamp(),
        ]
        let userID: [String: Any] = [
            "user_id": user.uid
        ]
        
        
        try await ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).setData(userID, merge: false)
        let likeDocRef = ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).collection("user_likes")
        
        
        var ref: DocumentReference? = nil
        ref = likeDocRef.addDocument(data: likeData) { error in
            if let error = error {
                print("Error: addLikesInDB: \(error)")
            } else {
                print("addLikesInDB: like added with ID: \(ref!.documentID)")
            }
        }
        
    }*/
    
    func fetchLikesFromDB(note_id: String,
                           completion: @escaping ([LikeModel]?) -> ()) async throws {
        
        let likeDocRef = ratingsreviewsCollection.document(note_id).collection("user_id")
        
        likeDocRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetchUserPosts: \(error)")
                completion(nil)
                return
            }
            
            var likes: [LikeModel] = []
            
            for document in querySnapshot!.documents {
                
                let likesCollectionRef = document.reference.collection("user_likes")
                likesCollectionRef.getDocuments { (reviewQuerySnapshot, errorr) in
                    if let postsError = errorr {
                        print("Error fetchReviewFromDB 1: \(postsError)")
                        completion(nil)
                        return
                    }
                    
                    for postDocument in reviewQuerySnapshot!.documents {
                        let data = postDocument.data()
                        
                        let like = LikeModel(data: data)
                        
                        likes.append(like)
                    }
                    
                    completion(likes)
                }
            }
        }
    }
    
    
//    func fetchUserBookmarkNoteId(completion: @escaping ([IdsModel]?) -> ()) async throws {
//
//        guard let user = Auth.auth().currentUser else { return }
//
//        let bookmarkIdRef =   userCollection.document(user.uid).collection("user_bookmarks")
//
//
//        bookmarkIdRef.getDocuments { (querySnapshot, error) in
//            if let error = error {
//                print("Error fetchUserPosts: \(error)")
//                completion(nil)
//                return
//            }
//
//            var ids: [IdsModel] = []
//
//            for doc in querySnapshot!.documents {
//                let data = doc.data()
//
//                let id = IdsModel(data: data)
//
//                ids.append(id)
//            }
//
//            completion(ids)
//        }
//    }
    
    func fetchUserBookmarkNoteId() async throws -> [IdsModel]? {
        guard let user = Auth.auth().currentUser else { throw UserError.userNotLogin }
        
        let bookmarkIdRef = userCollection.document(user.uid).collection("user_bookmarks")
        
        do {
            let querySnapshot = try await bookmarkIdRef.getDocuments()
            
            var ids: [IdsModel] = []
            
            for doc in querySnapshot.documents {
                let data = doc.data()
                let id = IdsModel(data: data)
                ids.append(id)
            }
            
            return ids
        } catch {
            throw error
        }
    }
    
    func fetchOneNoteFromDB(standard_id: String, subject_id: String, note_id: String, completion: @escaping (NoteModel?) -> ()) async throws {
        
        let subjectDocRef = standardsCollection.document(standard_id)
        let noteDocumentSnapshot = try await subjectDocRef
                    .collection("subjects")
                    .document(subject_id)
                    .collection("notes")
                    .document(note_id)
                    .getDocument()
        
        
        if noteDocumentSnapshot.exists {
            guard let data = noteDocumentSnapshot.data() else { return }
            let note = NoteModel(data: data)
            
            return completion(note)
        }
        else{
            return completion(nil)
        }
    }

    
    func addBookmarksInDB(standard_id: String, subject_id: String,note_id: String, isBookmark: BookmarkModel) async throws {
        
        
        guard let user = Auth.auth().currentUser else { return }
        
        let userID: [String: Any] = [
            "user_id": user.uid
        ]
        
        try await ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).setData(userID, merge: false)
        let bookmarkDocRef = ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).collection("user_bookmarks")
        
        
        var ref: DocumentReference? = nil
        ref = try bookmarkDocRef.addDocument(from: isBookmark, encoder: Coders.encoder) { error in
            if let error = error {
                print("Error: addBookmarksInDB: \(error)")
            } else {
                print("addBookmarksInDB: bookmark added with ID: \(ref!.documentID)")
            }
        }
        
        try await userCollection.document(user.uid).collection("user_bookmarks").document(note_id)
            .setData([
                "standard_id":standard_id,
                "note_id":note_id,
                "subject_id": subject_id], merge: false)
    }
    
    
    /*func addBookmarksInDB(note_id: String, isBookmark: Bool) async throws {
        
        
        guard let user = Auth.auth().currentUser else { return }
        
        let name = UserDefaults.standard.string(forKey: "full_name") ?? "UnKnown"
        let bookmarkData: [String: Any] = [
            
            "name": name,
            "isBookmark": isBookmark,
            "date_created": Timestamp(),
        ]
        let userID: [String: Any] = [
            "user_id": user.uid
        ]
        
        
        try await ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).setData(userID, merge: false)
        let bookmarkDocRef = ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).collection("user_bookmarks")
        
        
        var ref: DocumentReference? = nil
        ref = bookmarkDocRef.addDocument(data: bookmarkData) { error in
            if let error = error {
                print("Error: addBookmarksInDB: \(error)")
            } else {
                print("addBookmarksInDB: bookmark added with ID: \(ref!.documentID)")
            }
        }
        
    }*/
    
    
    func checkUserLike(note_id: String) async throws -> Bool {
        
        guard let user = Auth.auth().currentUser else { throw UserError.userNotLogin }
        
        let likeDocRef = ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).collection("user_likes")
        
        let querySnapshot = try await likeDocRef.getDocuments()
        return !querySnapshot.isEmpty
    }
    func checkUserBookmark(note_id: String) async throws -> Bool {
        
        guard let user = Auth.auth().currentUser else { throw UserError.userNotLogin }
        
        let bookmarkDocRef = ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).collection("user_bookmarks")
        
        let querySnapshot = try await bookmarkDocRef.getDocuments()
        return !querySnapshot.isEmpty
    }
    
    
    func fetchBookmarksFromDB(note_id: String,
                           completion: @escaping ([BookmarkModel]?) -> ()) async throws {
        
        let likeDocRef = ratingsreviewsCollection.document(note_id).collection("user_id")
        
        likeDocRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetchBookmarksFromDB: \(error)")
                completion(nil)
                return
            }
            
            var bookmarks: [BookmarkModel] = []
            
            for document in querySnapshot!.documents {
                
                let likesCollectionRef = document.reference.collection("user_likes")
                likesCollectionRef.getDocuments { (reviewQuerySnapshot, errorr) in
                    if let postsError = errorr {
                        print("Error fetchBookmarksFromDB 1: \(postsError)")
                        completion(nil)
                        return
                    }
                    
                    for postDocument in reviewQuerySnapshot!.documents {
                        let data = postDocument.data()
                        
                        let bookmark = BookmarkModel(data: data)
                        
                        bookmarks.append(bookmark)
                    }
                    
                    completion(bookmarks)
                }
            }
        }
    }
    
    func updateLikesCountInDB(standard_id: String, subject_id: String, note_id: String, count: Int) async throws {
        
        standardsCollection.document(standard_id).collection("subjects").document(subject_id).collection("notes").document(note_id).updateData(["likes_count": count]){ error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated!")
                }
            }
        
    }
}

