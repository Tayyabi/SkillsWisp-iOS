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
    let name: String?
    let like: Bool
    var dateCreated = Timestamp()
    
    init(name: String?, like: Bool) {
        self.name = name
        self.like = like
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String
        self.like = data["like"] as? Bool ?? false
        
    }
    
}
