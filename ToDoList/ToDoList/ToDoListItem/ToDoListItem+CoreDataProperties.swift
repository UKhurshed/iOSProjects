//
//  ToDoListItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Khurshed Umarov on 14.10.2021.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var data: Date?

}

extension ToDoListItem : Identifiable {

}
