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
    @Published var savedRatings: [RatingModel] = []
    
    @Published var fiveStar: Int = 0
    @Published var fourStar: Int = 0
    @Published var threeStar: Int = 0
    @Published var twoStar: Int = 0
    @Published var oneStar: Int = 0
    @Published var totalRating: Double = 0
    
    @Published var isLoading = false
    
    let reviewDataService = ReviewsDataService()
    
    
    
    
    func addReview(standardId: String, subjectId: String, noteId: String, review: String) async throws {
        
        do {
            let name = UserDefaults.standard.string(forKey: "full_name") ?? "UnKnown"
            let picUrl = UserDefaults.standard.string(forKey: "pictrue_url") ?? "UnKnown"
            let revieww = ReviewModel(review: review, name: name, picUrl: picUrl)
            try await reviewDataService.addReviewInDB(note_id: noteId, review: revieww)
            
           // try await reviewDataService.addReviewInDB(note_id: noteId, review: review)
            
            await fetchReviews(standard_id: standardId, subject_id: subjectId, note_id: noteId)
            
            try await reviewDataService.updateReviewCountInDB(standard_id: standardId, subject_id: subjectId, note_id: noteId, count: Int64(savedEntities.count))
        }
        catch{
            print("Error createUser: \(error)")
        }
        
    }
    
    func fetchReviews(standard_id:String, subject_id: String, note_id: String) async {
        
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
        
    }
    
    func fetchRatings(note_id: String) async {
        
        do {
            try await reviewDataService.fetchRatingsFromDB(note_id: note_id, completion: { ratings in
                
                guard let ratings = ratings else {
                    return
                }
                self.savedRatings.removeAll()
                self.savedRatings.append(contentsOf: ratings)
                
                self.individualRatings()
            })
        }
        catch {
            print("Error fetchReviews: \(error)")
        }
        
    }
    func individualRatings() {
        
        for rating in savedRatings {
            
            switch rating.rating {
                
            case 5:
                fiveStar+=1
            case 4:
                fourStar+=1
            case 3:
                threeStar+=1
                totalRating += 3/5
            case 2:
                twoStar+=1
            case 1:
                oneStar+=1
            default: break
                
            }
        }
        totalRating/=Double(savedRatings.count)
        totalRating*=5
    }
    
    
}
