//
//  SubjectModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 23/07/2023.
//

import Foundation
struct SubjectModel: Codable {
    
    let subjectId: String
    let name: String?
    let description: String?
    
    
    init(subjectId: String, name: String?, description: String?) {
        self.subjectId = subjectId
        self.name = name
        self.description = description
    }
    
    
    init(data: [String: Any]) {
        self.subjectId = data["subject_id"] as? String ?? "UNKNOWN"
        self.name = data["name"] as? String
        self.description = data["description"] as? String
        
    }
    
}
