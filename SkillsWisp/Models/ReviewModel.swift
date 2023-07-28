//
//  ReviewModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 28/07/2023.
//

import Foundation

struct ReviewModel: Codable {
    
    let review_id: String?
    let review: String?
    let name: String?
    
    init(review_id: String?, review: String?, name: String?) {
        self.review_id = review_id
        self.review = review
        self.name = name
    }
    
}
