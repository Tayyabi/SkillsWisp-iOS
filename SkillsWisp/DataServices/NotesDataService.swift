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

final class NotesDataService {
    
    private let ratingsreviewsCollection = Firestore.firestore().collection("ratings_reviews")
    private let standardsCollection = Firestore.firestore().collection("standards")
    
    
    func addLikesInDB(note_id: String, like: Bool) async throws {
        
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
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
        
        
        
        print("addLikesInDB: Like Created")
        
    }
    
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
                        
                        let like = LikeModel(like_id: data["like_id"] as? String ?? "UNKNOWN", name: data["name"] as? String ?? "UNKNOWN", like: data["like"] as? Bool ?? false)
                        
                        likes.append(like)
                    }
                    
                    completion(likes)
                }
            }
        }
    }
    
    
    
    
    
    
    
    func addBookmarksInDB(note_id: String, isBookmark: Bool) async throws {
        
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
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
        
        print("addBookmarksInDB: bookmark Created")
        
        
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
                        
                        let bookmark = BookmarkModel(bookmark_id: data["bookmark_id"] as? String ?? "UNKNOWN", name: data["name"] as? String ?? "UNKNOWN", isBookmark: data["isBookmark"] as? Bool ?? false)
                        
                        bookmarks.append(bookmark)
                    }
                    
                    completion(bookmarks)
                }
            }
        }
    }
    
    func updateLikesCountInDB(standard_id: String, subject_id: String, note_id: String, count: Int64) async throws {
        
        standardsCollection.document(standard_id).collection("subjects").document(subject_id).collection("notes").document(note_id).updateData(["likes_count": count]){ error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated!")
                }
            }
        
    }
    
    func updateReviewCountInDB(standard_id: String, subject_id: String, note_id: String, count: Int64) async throws {
        
        standardsCollection.document(standard_id).collection("subjects").document(subject_id).collection("notes").document(note_id).updateData(["review_count": count]){ error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated!")
                }
            }
        
    }
}

