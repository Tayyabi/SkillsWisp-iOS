//
//  BookmarkModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 03/08/2023.
//

import Foundation
import Firebase

struct BookmarkModel: Codable {
    
    var bookmarkId: String? = UUID().uuidString
    let isBookmark: Bool
    let userId: String?
    
    init(isBookmark: Bool, userId: String) {
        self.isBookmark = isBookmark
        self.userId = userId
    }
    
    
    init(data: [String: Any]) {
        self.isBookmark = data["is_bookmark"] as? Bool ?? false
        self.userId = data["user_id"] as? String
    }
    
}
