//
//  PastSubjectModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 10/09/2023.
//

import Foundation

struct PastSubjectModel: Codable {
    
    var subject_id: String? = UUID().uuidString
    let name: String?
    let url: String?
    let year: Int?
    
    init(name: String, url: String, year: Int) {
        self.name = name
        self.url = url
        self.year = year
    }
    
    
    init(data: [String: Any]) {
        
        self.subject_id = data["subject_id"] as? String
        self.name = data["name"] as? String
        self.url = data["url"] as? String
        self.year = data["year"] as? Int
    }
}
