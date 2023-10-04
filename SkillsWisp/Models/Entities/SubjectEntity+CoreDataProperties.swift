//
//  SubjectEntity+CoreDataProperties.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/07/2023.
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
    @NSManaged public var notes_id: NSSet?
    @NSManaged public var standard_id: StandardEntity?

}

// MARK: Generated accessors for notes_id
extension SubjectEntity {

    @objc(addNotes_idObject:)
    @NSManaged public func addToNotes_id(_ value: NotesEntity)

    @objc(removeNotes_idObject:)
    @NSManaged public func removeFromNotes_id(_ value: NotesEntity)

    @objc(addNotes_id:)
    @NSManaged public func addToNotes_id(_ values: NSSet)

    @objc(removeNotes_id:)
    @NSManaged public func removeFromNotes_id(_ values: NSSet)

}

extension SubjectEntity : Identifiable {

}
