//
//  SourceItemEntity+CoreDataProperties.swift
//  info_systems_problem
//
//  Created by Khurshed Umarov on 28.10.2021.
//
//

import Foundation
import CoreData


extension SourceItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceItemEntity> {
        return NSFetchRequest<SourceItemEntity>(entityName: "SourceItemEntity")
    }

    @NSManaged public var itemName: String?

}

extension SourceItemEntity : Identifiable {

}
