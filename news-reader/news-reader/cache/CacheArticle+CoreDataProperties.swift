//
//  CacheArticle+CoreDataProperties.swift
//  news-reader
//
//  Created by Giang Pham on 12/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//
//

import Foundation
import CoreData


extension CacheArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheArticle> {
        return NSFetchRequest<CacheArticle>(entityName: "CacheArticle")
    }

    @NSManaged public var author: String?
    @NSManaged public var description_: String
    @NSManaged public var title: String
    @NSManaged public var url: String
    @NSManaged public var urlToImage: String?
    @NSManaged public var belongsTo: CacheSource
    @NSManaged public var createdAt: Date

}
