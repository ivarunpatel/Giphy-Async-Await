//
//  CDFeedPage+CoreDataProperties.swift
//  GiphyAsyncAwait
//
//  Created by Varun on 19/05/23.
//
//

import Foundation
import CoreData

@objc(CDFeedPage)
public class CDFeedPage: NSManagedObject {
    @NSManaged public var totalCount: Int16
    @NSManaged public var count: Int16
    @NSManaged public var offset: Int16
    @NSManaged public var giphy: NSOrderedSet
}

extension CDFeedPage {
    static func find(in context: NSManagedObjectContext) throws -> CDFeedPage? {
        let request = NSFetchRequest<CDFeedPage>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
    
    var toLocal: [LocalFeed] {
        giphy.compactMap { ($0 as? CDFeedItem)?.local}
    }
}
