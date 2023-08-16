//
//  UserModel.swift
//  SkillsWisp
//
//  Created by M Tayyab on 22/07/2023.
//

import Foundation

struct UserModel: Codable {
    
    let userId: String
    var fullName: String?
    var email: String
    var phoneNo: String?
    var picUrl: String?
    var dateCreated: Date?
    
    init(userId: String = "",fullName: String = "",email: String = "",phoneNo: String = "",picUrl: String = "") {
        self.userId = userId
        self.fullName = fullName
        self.email = email
        self.phoneNo = phoneNo
        self.picUrl = picUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case fullName = "full_name"
        case email = "email"
        case phoneNo  = "phone_no"
        case picUrl = "photo_url"
        case dateCreated = "date_created"
    }
    
}
