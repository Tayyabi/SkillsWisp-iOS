//
//  StandardEntity+CoreDataProperties.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/07/2023.
//
//

import Foundation
import CoreData


extension StandardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StandardEntity> {
        return NSFetchRequest<StandardEntity>(entityName: "StandardEntity")
    }

    @NSManaged public var descrip: String?
    @NSManaged public var name: String?
    @NSManaged public var standard_id: UUID?
    @NSManaged public var subject_id: NSSet?

}

// MARK: Generated accessors for subject_id
extension StandardEntity {

    @objc(addSubject_idObject:)
    @NSManaged public func addToSubject_id(_ value: SubjectEntity)

    @objc(removeSubject_idObject:)
    @NSManaged public func removeFromSubject_id(_ value: SubjectEntity)

    @objc(addSubject_id:)
    @NSManaged public func addToSubject_id(_ values: NSSet)

    @objc(removeSubject_id:)
    @NSManaged public func removeFromSubject_id(_ values: NSSet)

}

extension StandardEntity : Identifiable {

}
