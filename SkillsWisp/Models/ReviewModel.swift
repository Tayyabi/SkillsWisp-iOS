//
//  ReviewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 28/07/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ReviewModel: Codable {
    
    
    var reviewId: String? = UUID().uuidString
    var review: String?
    var name: String?
    var picUrl: String?
    var dateCreated = Timestamp()
    
//    init(reviewId: String, review: String?, name: String?, picUrl: String?) {
//        self.reviewId = reviewId
//        self.review = review
//        self.name = name
//        self.picUrl = picUrl
//    }
    
    init(review: String?, name: String?, picUrl: String?) {
        self.review = review
        self.name = name
        self.picUrl = picUrl
    }
    
    init(data: [String: Any]) {
        self.reviewId = data["review_id"] as? String ?? "UNKNOWN"
        self.review = data["review"] as? String
        self.name = data["name"] as? String
        self.picUrl = data["pic_url"] as? String
        
    }
    
}
