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
    static func find(with offset: Int, in context: NSManagedObjectContext) throws -> CDFeedPage? {
        let request = NSFetchRequest<CDFeedPage>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "offset == %d", offset)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
    
    static func delete(in context: NSManagedObjectContext) throws {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity().name!)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(deleteRequest)
    }
    
    var toLocal: [LocalFeed] {
        giphy.compactMap { ($0 as? CDFeedItem)?.local}
    }
}
