//
//  RatingViewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 29/07/2023.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class RatingViewModel: ObservableObject {
    
    @Published var savedEntities: [ReviewModel] = []
    @Published var isLoading = false
    
    let reviewDataService = ReviewsDataService()
    
    
    
    
    func addRating(note_id: String, rating: Int) async throws {
        
        do {
            try await reviewDataService.addRatingInDB(note_id: note_id, rating: rating)
            
        }
        catch{
            print("Error createUser: \(error)")
        }
        
        
        
    }
    
    /*func fetchReviews(note_id: String) async {
        
        do {
            try await reviewDataService.fetchReviewFromDB(note_id: note_id, completion: { reviews in
                
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
        
    }*/
    
    
}
