//
//  BookmarkModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 03/08/2023.
//

import Foundation

struct BookmarkModel: Codable {
    
    var bookmarkId: String? = UUID().uuidString
    let name: String?
    let isBookmark: Bool
    
    init(name: String?, isBookmark: Bool) {
        self.name = name
        self.isBookmark = isBookmark
    }
    
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String
        self.isBookmark = data["is_bookmark"] as? Bool ?? false
        
    }
    
}
