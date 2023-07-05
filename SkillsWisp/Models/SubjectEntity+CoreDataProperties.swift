//
//  SubjectEntity+CoreDataProperties.swift
//  SkillsWisp
//
//  Created by M Tayyab on 03/07/2023.
//
//

import Foundation
import CoreData


extension SubjectEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubjectEntity> {
        return NSFetchRequest<SubjectEntity>(entityName: "SubjectEntity")
    }

    @NSManaged public var descrip: String?
    @NSManaged public var name: String?
    @NSManaged public var subject_id: UUID?
    @NSManaged public var standard_id: StandardEntity?

}

extension SubjectEntity : Identifiable {

}
