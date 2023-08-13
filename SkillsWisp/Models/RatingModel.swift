//
//  RatingModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 02/08/2023.
//

import Foundation

struct RatingModel: Codable {
    
    let ratingId: String
    let rating: Int?
    
    init(ratingId: String, rating: Int?) {
        self.ratingId = ratingId
        self.rating = rating
    }
    
    
    init(data: [String: Any]) {
        self.ratingId = data["rating_id"] as? String ?? "UNKNOWN"
        self.rating = data["review"] as? Int
    }
}
