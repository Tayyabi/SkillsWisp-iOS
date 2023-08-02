//
//  RatingModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 02/08/2023.
//

import Foundation

struct RatingModel: Codable {
    
    let rating_id: String?
    let rating: Int?
    
    init(rating_id: String?, rating: Int?) {
        self.rating_id = rating_id
        self.rating = rating
    }
    
}
