//
//  StandardModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 22/07/2023.
//

import Foundation
struct StandardModel: Codable {
    
    let standardId: String?
    let name: String?
    let description: String?
    
    
    init(standardId: String?, name: String?, description: String?) {
        self.standardId = standardId
        self.name = name
        self.description = description
    }
    
    
    init(data: [String: Any]) {
        self.standardId = data["standard_id"] as? String
        self.name = data["name"] as? String
        self.description = data["description"] as? String
        
    }
    
}
