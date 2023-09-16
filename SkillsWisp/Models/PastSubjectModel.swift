//
//  PastSubjectModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 10/09/2023.
//

import Foundation


struct PastSubjectModel: Codable {
    
    var id: String? = UUID().uuidString
    let name: String?
    let url: String?
    let type: String?
    let year: Int?
    
    init(name: String, url: String,type: String, year: Int) {
        self.name = name
        self.url = url
        self.year = year
        self.type = type
    }
    
    
    init(data: [String: Any], isSub: Bool) {
        
        if(isSub) {
            self.id = data["subject_id"] as? String
        }
        else{
            self.id = data["date_sheet_id"] as? String
        }
        self.name = data["name"] as? String
        self.url = data["url"] as? String
        self.type = data["type"] as? String
        self.year = data["year"] as? Int
    }
}
