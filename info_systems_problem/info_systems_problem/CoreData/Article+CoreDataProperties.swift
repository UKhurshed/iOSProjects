//
//  Article+CoreDataProperties.swift
//  info_systems_problem
//
//  Created by Khurshed Umarov on 27.10.2021.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var newsUrl: String?
    @NSManaged public var urlToImage: String?

}

extension ArticleEntity : Identifiable {

}
