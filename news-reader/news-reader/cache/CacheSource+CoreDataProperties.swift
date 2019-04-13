//
//  CacheSource+CoreDataProperties.swift
//  news-reader
//
//  Created by Giang Pham on 12/04/2019.
//  Copyright © 2019 Giang Pham. All rights reserved.
//
//

import Foundation
import CoreData


extension CacheSource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheSource> {
        return NSFetchRequest<CacheSource>(entityName: "CacheSource")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String
}
