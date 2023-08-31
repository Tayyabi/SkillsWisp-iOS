//
//  LikeModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 03/08/2023.
//

import Foundation
import Firebase

struct LikeModel: Codable {
    
    var like_id: String? = UUID().uuidString
    let isLike: Bool
    var dateCreated = Timestamp()
    
    init(isLike: Bool) {
        self.isLike = isLike
    }
    
    init(data: [String: Any]) {
        self.isLike = data["isLike"] as? Bool ?? false
        
    }
    
}
