//
//  UsersEntity+CoreDataProperties.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/07/2023.
//
//

import Foundation
import CoreData


extension UsersEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsersEntity> {
        return NSFetchRequest<UsersEntity>(entityName: "UsersEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var full_name: String?
    @NSManaged public var phone_no: String?
    @NSManaged public var pic_url: String?
    @NSManaged public var user_id: UUID?

}

extension UsersEntity : Identifiable {

}
