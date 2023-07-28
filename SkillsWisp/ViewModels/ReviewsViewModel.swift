//
//  ReviewsViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 27/07/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ReviewsViewModel: ObservableObject {
    
    @Published var savedEntities: [ReviewModel] = []
    @Published var isLoading = false
    
    let reviewDataService = ReviewsDataService()
    
    
    
    
    func addReview(standard_id: String, subject_id: String, note_id: String, review: String) async throws {
        
        do {
            try await reviewDataService.addReviewInDB(standard_id: standard_id, subject_id: subject_id, note_id: note_id, review: review)
            
            await fetchReviews(standard_id: standard_id, subject_id: subject_id, note_id: note_id)
        }
        catch{
            print("Error createUser: \(error)")
        }
        
        
        
    }
    
    func fetchReviews(standard_id: String, subject_id: String, note_id: String) async {
        
        do {
            try await reviewDataService.fetchReviewFromDB(standard_id: standard_id,
                                                          subject_id: subject_id,
                                                          note_id: note_id, completion: { reviews in
                
                guard let reviews = reviews else {
                    return
                }
                self.savedEntities.removeAll()
                self.savedEntities.append(contentsOf: reviews)
                
                self.isLoading = false
            })
        }
        catch {
            print("Error fetchReviews: \(error)")
        }
        
    }
    
    
}
