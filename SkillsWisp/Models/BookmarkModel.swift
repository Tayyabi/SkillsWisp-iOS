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
    var dateCreated = Timestamp()
    
    init(isBookmark: Bool) {
        self.isBookmark = isBookmark
    }
    
    
    init(data: [String: Any]) {
        self.isBookmark = data["is_bookmark"] as? Bool ?? false
    }
    
}
