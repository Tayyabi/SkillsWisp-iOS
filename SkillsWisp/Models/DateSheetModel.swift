//
//  DateSheetModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/09/2023.
//

import Foundation

struct DateSheetModel: Codable {
    
    var date_sheet_id: String? = UUID().uuidString
    let classs: String?
    var url: String?
    var year: Int?
    
    init(classs: String, url: String, year: Int) {
        self.classs = classs
        self.url = url
        self.year = year
    }
    
    
    init(data: [String: Any]) {
        
        self.date_sheet_id = data["date_sheet_id"] as? String
        self.classs = data["class"] as? String
        self.url = data["url"] as? String
        self.year = data["year"] as? Int
    }
}
