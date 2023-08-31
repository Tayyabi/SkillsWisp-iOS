//
//  IdsModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 19/08/2023.
//

import Foundation

struct IdsModel: Codable {
    
    var standard_id: String
    let subject_id: String
    let note_id: String
    
    init(standard_id: String, subject_id: String, note_id: String) {
        self.standard_id = standard_id
        self.subject_id = subject_id
        self.note_id = note_id
    }
    
    init(data: [String: Any]) {
        self.standard_id = data["standard_id"] as! String
        self.subject_id = data["subject_id"] as! String
        self.note_id = data["note_id"] as! String
        
    }
    
}
