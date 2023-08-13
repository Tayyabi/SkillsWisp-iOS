//
//  ReviewsDataService.swift
//  SkillsWisp
//
//  Created by M Tayyab on 27/07/2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ReviewsDataService {
    
    private let ratingsreviewsCollection = Firestore.firestore().collection("ratings_reviews")
    private let standardsCollection = Firestore.firestore().collection("standards")
    
    
    func addReviewInDB(note_id: String, review: ReviewModel) async throws {
        
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        let name = UserDefaults.standard.string(forKey: "full_name") ?? "UnKnown"
        let reviewData: [String: Any] = [
            
            "name": name,
            "pic_url": "",
            "review": review,
            "date_created": Timestamp(),
        ]
        let userID: [String: Any] = [
            "user_id": user.uid
        ]
        
        
        
        
        try await ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).setData(userID, merge: false)
        let reviewDocRef = ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).collection("user_reviews")
        
        
        var ref: DocumentReference? = nil
        ref = reviewDocRef.addDocument(data: reviewData) { error in
            if let error = error {
                print("Error: addReviewInDB: \(error)")
            } else {
                print("addReviewInDB: Review added with ID: \(ref!.documentID)")
            }
        }
        
        print("addReviewInDB: Review Created")
        
        
    }
    
    
    func addReviewInDB(note_id: String, review: String) async throws {
        
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        let name = UserDefaults.standard.string(forKey: "full_name") ?? "UnKnown"
        let reviewData: [String: Any] = [
            
            "name": name,
            "pic_url": "",
            "review": review,
            "date_created": Timestamp(),
        ]
        let userID: [String: Any] = [
            "user_id": user.uid
        ]
        
        
        
        
        try await ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).setData(userID, merge: false)
        let reviewDocRef = ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).collection("user_reviews")
        
        
        var ref: DocumentReference? = nil
        ref = reviewDocRef.addDocument(data: reviewData) { error in
            if let error = error {
                print("Error: addReviewInDB: \(error)")
            } else {
                print("addReviewInDB: Review added with ID: \(ref!.documentID)")
            }
        }
        
        print("addReviewInDB: Review Created")
        
        
    }
    
    func fetchReviewFromDB(note_id: String,
                           completion: @escaping ([ReviewModel]?) -> ()) async throws {
        
        let reviewDocRef = ratingsreviewsCollection.document(note_id).collection("user_id")
        
        reviewDocRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetchUserPosts: \(error)")
                completion(nil)
                return
            }
            
            var reviews: [ReviewModel] = []
            
            for document in querySnapshot!.documents {
                
                let reviewsCollectionRef = document.reference.collection("user_reviews")
                reviewsCollectionRef.getDocuments { (reviewQuerySnapshot, errorr) in
                    if let postsError = errorr {
                        print("Error fetchReviewFromDB 1: \(postsError)")
                        completion(nil)
                        return
                    }
                    
                    for postDocument in reviewQuerySnapshot!.documents {
                        let data = postDocument.data()
                        
                        let review = ReviewModel(data: data)
                        reviews.append(review)
                    }
                    
                    completion(reviews)
                }
            }
        }
    }
    func fetchRatingsFromDB(note_id: String,
                           completion: @escaping ([RatingModel]?) -> ()) async throws {
        
        let reviewDocRef = ratingsreviewsCollection.document(note_id).collection("user_id")
        
        reviewDocRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetchUserPosts: \(error)")
                completion(nil)
                return
            }
            
            var ratings: [RatingModel] = []
            
            for document in querySnapshot!.documents {
                
                let raingsCollectionRef = document.reference.collection("user_ratings")
                raingsCollectionRef.getDocuments { (reviewQuerySnapshot, errorr) in
                    if let postsError = errorr {
                        print("Error fetchReviewFromDB 1: \(postsError)")
                        completion(nil)
                        return
                    }
                    
                    for postDocument in reviewQuerySnapshot!.documents {
                        let data = postDocument.data()
                        
                        let rating = RatingModel(data: data)
                        ratings.append(rating)
                    }
                    
                    completion(ratings)
                }
            }
        }
    }
    
    
    
    func addRatingInDB(note_id: String, rating: Int) async throws {
        
        
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        let ratingData: [String: Any] = [
            "rating": rating,
            "date_created": Timestamp(),
        ]
        let userID: [String: Any] = [
            "user_id": user.uid
        ]
        
        
        
        
        try await ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).setData(userID, merge: false)
        let reviewDocRef = ratingsreviewsCollection.document(note_id).collection("user_id").document(user.uid).collection("user_ratings")
        
        
        var ref: DocumentReference? = nil
        ref = reviewDocRef.addDocument(data: ratingData) { error in
            if let error = error {
                print("Error: addReviewInDB: \(error)")
            } else {
                print("addReviewInDB: Review added with ID: \(ref!.documentID)")
            }
        }
        
        print("addReviewInDB: Review Created")
        
        
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

