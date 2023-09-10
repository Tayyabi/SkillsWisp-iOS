//
//  PastPaperModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/09/2023.
//

import Foundation

struct PastPaperModel: Codable {
    
    var past_paper_id: String? = UUID().uuidString
    let classs: String?
    var standard: Int?
    
    init(classs: String, standard: Int) {
        self.classs = classs
        self.standard = standard
    }
    
    
    init(data: [String: Any]) {
        
        self.past_paper_id = data["past_paper_id"] as? String
        self.classs = data["class"] as? String
        self.standard = data["standard"] as? Int
    }
}
