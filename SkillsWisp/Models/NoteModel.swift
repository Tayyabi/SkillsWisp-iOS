//
//  NoteModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 23/07/2023.
//

import Foundation

struct NoteModel: Codable {
    
    let noteId: String?
    let name: String?
    let chapter: String?
    let rating: Double
    let localUrl: String?
    let likesCount: Int?
    let reviewCount: Int?
    let bookmark: Bool?
    let thumbnail: String?
    
    init(noteId: String, name: String?, chapter: String?, rating: Double,
         localUrl: String?, likesCount: Int,reviewCount: Int, bookmark: Bool, thumbnail: String?) {
        
        self.noteId = noteId
        self.name = name
        self.chapter = chapter
        self.rating = rating
        self.localUrl = localUrl
        self.likesCount = likesCount
        self.reviewCount = reviewCount
        self.bookmark = bookmark
        self.thumbnail = thumbnail
    }
    
    
    init(data: [String: Any]) {
        
        self.noteId = data["note_id"] as? String
        self.name = data["name"] as? String
        self.chapter = data["chapter"] as? String
        self.rating = data["rating"] as! Double
        self.localUrl = data["local_url"] as? String
        self.likesCount = data["likes_count"] as? Int
        self.reviewCount = data["review_count"] as? Int
        self.bookmark = data["bookmark"] as? Bool
        self.thumbnail = data["thumbnail"] as? String
        
    }
    
}
