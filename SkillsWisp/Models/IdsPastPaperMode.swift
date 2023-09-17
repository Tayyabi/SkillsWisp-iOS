//
//  IdsPastPaperMode.swift
//  SkillsWisp
//
//  Created by M Tayyab on 17/09/2023.
//

import Foundation

struct IdsPastPaperModel: Codable {
    
    var past_paper_id: String?
    let subject_id: String?
    let is_bookmark: Bool
    
    init(past_paper_id: String, subject_id: String, is_bookmark: Bool) {
        self.past_paper_id = past_paper_id
        self.subject_id = subject_id
        self.is_bookmark = is_bookmark
    }
    
    init(data: [String: Any]) {
        self.past_paper_id = data["past_paper_id"] as? String
        self.subject_id = data["subject_id"] as? String
        self.is_bookmark = data["is_bookmark"] as? Bool ?? false
    }
    
}
