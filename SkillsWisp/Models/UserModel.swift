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
    
    init(userId: String = "",fullName: String = "",email: String = "",phoneNo: String = "",picUrl: String = "") {
        self.userId = userId
        self.fullName = fullName
        self.email = email
        self.phoneNo = phoneNo
        self.picUrl = picUrl
    }
    
}
