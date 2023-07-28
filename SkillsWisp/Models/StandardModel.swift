//
//  StandardModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 22/07/2023.
//

import Foundation
struct StandardModel: Codable {
    
    let standard_id: String?
    let name: String?
    let description: String?
    
    
    init(standard_id: String?, name: String?, description: String?) {
        self.standard_id = standard_id
        self.name = name
        self.description = description
    }
    
}
