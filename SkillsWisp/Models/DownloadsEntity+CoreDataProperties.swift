//
//  DownloadsEntity+CoreDataProperties.swift
//  SkillsWisp
//
//  Created by M Tayyab on 17/09/2023.
//
//

import Foundation
import CoreData


extension DownloadsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DownloadsEntity> {
        return NSFetchRequest<DownloadsEntity>(entityName: "DownloadsEntity")
    }

    @NSManaged public var chapter: String?
    @NSManaged public var local_url: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var rating: Double
    @NSManaged public var type: String?
    @NSManaged public var category: String?

}

extension DownloadsEntity : Identifiable {

}
