//
//  SubjectModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 23/07/2023.
//

import Foundation
struct SubjectModel: Codable {
    
    let subject_id: String?
    let name: String?
    let description: String?
    
    
    init(subject_id: String?, name: String?, description: String?) {
        self.subject_id = subject_id
        self.name = name
        self.description = description
    }
    
}
