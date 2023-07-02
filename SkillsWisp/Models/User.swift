//
//  User.swift
//  SkillsWisp
//
//  Created by M Tayyab on 01/07/2023.
//

import Foundation

struct User: Codable, Hashable {
    
    var user_id: UUID
    var full_name: String
    var email: String
    var phone_no: String
    var pic_url: String
    
}
