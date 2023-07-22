//
//  UserModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 22/07/2023.
//

import Foundation

struct UserModel: Codable {
    
    let user_id: String?
    let full_name: String?
    let email: String?
    let phone_no: String?
    let pic_url: String?
    
    init(user_id: String = "",full_name: String = "",email: String = "",phone_no: String = "",pic_url: String = "") {
        self.user_id = user_id
        self.full_name = full_name
        self.email = email
        self.phone_no = phone_no
        self.pic_url = pic_url
        
    }
    
}
