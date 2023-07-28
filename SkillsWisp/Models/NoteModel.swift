//
//  NoteModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 23/07/2023.
//

import Foundation

struct NoteModel: Codable {
    
    let notes_id: String?
    let name: String?
    let chapter: String?
    let rating: Double
    let local_url: String?
    let likes_count: Int64
    let bookmark: Bool
    let thumbnail: String?
    
    init(notes_id: String?, name: String?, chapter: String?, rating: Double,
         local_url: String?, likes_count: Int64, bookmark: Bool, thumbnail: String?) {
        
        self.notes_id = notes_id
        self.name = name
        self.chapter = chapter
        self.rating = rating
        self.local_url = local_url
        self.likes_count = likes_count
        self.bookmark = bookmark
        self.thumbnail = thumbnail
    }
    
}
