//
//  ReviewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 28/07/2023.
//

import Foundation

struct ReviewModel: Codable {
    
    let reviewId: String
    let review: String?
    let name: String?
    let picUrl: String?
    
    init(reviewId: String, review: String?, name: String?, picUrl: String?) {
        self.reviewId = reviewId
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
