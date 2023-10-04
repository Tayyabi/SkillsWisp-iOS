//
//  NotesEntity+CoreDataProperties.swift
//  SkillsWisp
//
//  Created by M Tayyab on 09/07/2023.
//
//

import Foundation
import CoreData


extension NotesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotesEntity> {
        return NSFetchRequest<NotesEntity>(entityName: "NotesEntity")
    }

    @NSManaged public var bookmark: Bool
    @NSManaged public var chapter: String?
    @NSManaged public var likes_count: Int64
    @NSManaged public var local_url: String?
    @NSManaged public var name: String?
    @NSManaged public var notes_id: UUID?
    @NSManaged public var rating: Double
    @NSManaged public var subject_id: SubjectEntity?

}

extension NotesEntity : Identifiable {

}
